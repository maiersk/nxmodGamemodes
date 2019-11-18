Faction = Faction or {}
Faction.group = Faction.group or {}
Faction.group.list = Faction.group.list or {}

Faction.group.SUPERADMIN = 2
Faction.group.ADMIN = 1
Faction.group.MENUBAR = 0

if (SERVER) then

    function Faction.group:Init()
        self:Setting()

    end

    --添加新权限组
    function Faction.group:Add(power, name, tbl, insert)
        --如果已存在返回
        if self:isExist(name) then return end
        
        self.list[name] = tbl
        --权值
        if (power) then
            self.list[name].power = power
        end
        --继承的权限
        if (insert) then
            for k, v in pairs(insert) do
                if (type(v) != "table" && k != "power" && k != "id") then
                    table.insert(self.list[name], v)
                end
            end
        end
        --插入到数据库
        Faction.sql:InsertTo("faction_group", {
            name = name,
            --permission = table.ToString(tbl)
        })
        --插入数据库id值
        self.list[name].id = Faction.sql:SelectVal("faction_group", "id", "name", name) or -1
        
        return tbl
    end

    --是否能使用指定权限
    function Faction.group:CanDoAction(plyinfo, action, opply)
        if (plyinfo) then
            local operator
            if (!opply) then
                operator = plyinfo.groupid
            else
                operator = opply:GetMenubarInfo().groupid
            end
            print(operator)
            for k, v in pairs(self.list[self:get(operator).group]) do
                if (v == action) then
                    return true
                end
            end
        end
        notice.Add(opply, "你没有执行 " .. action .. " 的权限", notice.NOTIFY_GENERIC, 5, "buttons/button10.wav")
        return false
    end

    function Faction.group:isExist(name)
        local data = Faction.sql:SelectVal("faction_group", "name", "name", name)
        if data == name then
            if self.list[data] then
                return true
            end 
        end
        return false
    end

    function Faction.group:Setting()

        table.Empty( Faction.group.list )

        self:Add(self.SUPERADMIN, "SuperAdmin", {
            "changegroup",
            "dropgang" 
            }, self:Add(self.ADMIN, "Admin", {
                "kick",
                "usecash",
                "sendvote",
                }, self:Add(self.MENUBAR, "Menubar", {
                    "upcash",
                    "vote"
                })
            )
        )

        PrintTable(self.list)
    end

    function Faction.group:GetAll()
        return self.list
    end
    
end

function Faction.group:get(id)
    if (self.list) then
        for k, v in pairs(self.list) do
            if (v.id == tostring(id)) then
                return {group = k, power = v.power}
            end
        end
    end
    return -1
end
