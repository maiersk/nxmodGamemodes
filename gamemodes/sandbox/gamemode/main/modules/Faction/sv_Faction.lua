Faction = Faction or {}
Faction.gang = Faction.gang or {}

function Faction:Load()
    self.sql:Init()
    self.group:Init()
    self:Init()
    self.comm:Init()
    
    --PrintTable(Faction.gang)        
end  

function Faction:Init()
    local gang = Faction.sql:SelectAll("faction")
    for i = 0, #gang do
        local v = gang[i]
        if v then
            self:bat(v.ownerid, v.name, v.color, v.level, v.cash, self.sql:SelectWhere("faction_menubar", "factionid", v.id), v.id)
        end
    end
end

function Faction:bat(steamid, name, color, level, cash, menubar, id)
    local obj = self:new(nil, name, color, level, cash, menubar, id, true)
    if obj then 
        obj.ownerid = steamid 
    end
    --是否用于批量导入，是即insert
    if (level && color && cash && name && id) then
        table.insert(self.gang, obj)
    end
end

--新建gang，两种模式，noinsert用来批量导入使用，不insert
--普通模式，只用于新建
function Faction:new(ply, name, color, level, cash, menubar, id, noinsert)

    --帮派存在即返回
    if self:isExist(name) then return end

    --玩家是否加入了帮派，加入了即返回
    if ply && ply:hasGang() then return end

    --创建对象
    local obj = {}
    self.__index = self
    setmetatable(obj, self)
    obj.id = id or 0
    obj.name = name
    if ply then obj.ownerid = ply:SteamID() or 0 end
    if (type(color) == "table") then obj.color = util.TableToJSON(color) or "" else obj.color = color or util.TableToJSON(Color(255, 0, 0)) end
    obj.level = level or 0
    obj.cash = cash or 0
    obj.menubar = menubar or {}

    if !noinsert then
        if ( self.sql:InsertTo("faction", {
            name = obj.name,
            ownerid = obj.ownerid,
            color = obj.color,
            level = obj.level,
            cash = obj.cash
        }) ) then
            obj.id = self.sql:SelectVal("faction", "id", "ownerid", obj.ownerid)
            table.insert(self.gang, obj)
            self:JoinByid(ply, obj.id, "SuperAdmin")
        end
    end
    hook.Run("FactionToCL")
    return obj
end

--帮派是否已存在，存在即返回
function Faction:isExist(name) 
    if self.sql:SelectVal("faction", "name", "name", name) == name then
        if self.gang then
            for k, v in pairs(self.gang) do
                if v.name == name then
                    return true
                end
            end
        end
    end
    return false
end

function Faction:JoinByid(ply, id, group)

    local tbl = {
        id = self.sql:SelectVal("libk_player", "id", "player", ply:SteamID()),
        steamid = ply:SteamID(),
        factionid = id or self.id,
        groupid = self.sql:SelectVal("faction_group", "id", "name", group or "Menubar"),
        name = ply:Nick()
    }

    if ( self.sql:InsertTo("faction_menubar", tbl) ) then
        table.insert(self:getGang(id).menubar, tbl)
        hook.Run("FactionToCL")
    end
end

function Faction:ExitByid(plyid, id)
    print(plyid, id)
    if ( self.sql:DeleteByid("faction_menubar", "id",
            plyid, { cols = "factionid", vals = id }) ) then
        if self:getGang(id) then
            for k, v in pairs(self:getGang(id).menubar) do
                if v.id == plyid then
                    self:getGang(id).menubar[k] = nil
                    hook.Run("FactionToCL")
                end
            end
        end
    end
end

function Faction:SetColor(col, id)
    if (col) then
        local json = util.TableToJSON(col)
        if (self.sql:UpdateByid("faction", "id", id or self.id, { color = json })) then
            self.color = json
            
            hook.Run("FactionToCL")

            --local faction = self:getGang(id)
            local domains = self:getDomain()
        
            for k, domain in pairs(domains) do
                if (domain.flag.entindex) then
                    local flagent = ents.GetByIndex(domain.flag.entindex)
                    local col = self:getColor()
                    flagent:SetFlagColor(Color(col.r, col.g, col.b, col.a))
                end
            end
            
        end
    end
end

function Faction:SetName(str, id)
    if (str && id) then
        if (self.sql:UpdateByid("faction", "id", id, { name = str })) then
            self:getGang(id).name = str
            hook.Run("FactionToCL")
        end
    end
end

function Faction:SaveMoney(ply, count, id)
    if (count && id) then
        local cash = self.sql:SelectVal("faction", "cash", "id", id)
        if (cash) then
            cash = cash + count
        end
        
        if (ply:money_take( tonumber(count) )) then
            if (self.sql:UpdateByid("faction", "id", id, { cash = cash })) then
                self:getGang(id).cash = cash
                hook.Run("FactionToCL")
            end
        else
            notice.Add(ply, "余额不足无法存进", notice.NOTIFY_GENERIC, 5, "buttons/lever1.wav")
        end
    end
end

function Faction:TakeMoeny(ply, count, id)
    if (count && id) then
        local cash = self.sql:SelectVal("faction", "cash", "id", id)
        if (cash) then
            cash = cash - count
        end
        if (cash <= 0) then  notice.Add(ply, "余额不足无法取出", notice.NOTIFY_GENERIC, 5, "buttons/lever1.wav") return end

        if (self.sql:UpdateByid("faction", "id", id, { cash = cash })) then
            self:getGang(id).cash = cash
            ply:money_give( tonumber(count) )
            hook.Run("FactionToCL")
        end
    end
end



---需要使用权限的func
function Faction:Drop(plyid, id, opply)
    local plyinfo = self:getPlyinfoById(plyid)

    if self.group:CanDoAction(plyinfo, "dropgang", opply) then
        if ( self.sql:DeleteByid("faction", "id", id) and 
                self.sql:DeleteByid("faction_menubar", "factionid", id) and
                self.sql:UpdateByid("domain", "factionid", id, {factionid = -1})
            ) then
            for k, v in pairs(self.gang) do
                if v.id == id then
                    self.gang[k] = nil
                end
            end
        end
        hook.Run("FactionToCL")
        
        hook.Run("DomainToCL")
    end
end

function Faction:KickMenubar(plyid, opply)
    local plyinfo = self:getPlyinfoById(plyid)

    if self.group:CanDoAction(plyinfo, "kick", opply) then
        self:ExitByid(plyid, plyinfo.factionid)
    end
end

function Faction:ChangeGroup(plyid, group, opply)
    local plyinfo = self:getPlyinfoById(plyid)
    if self.group:CanDoAction(plyinfo, "changegroup", opply) || opply:IsSuperAdmin() then
        if (self.group:get(plyinfo.groupid).power >= self.group.SUPERADMIN) then
            notice.Add(opply, "帮主不能直接修改自己的权限，需要先把权限给予下一任", notice.NOTIFY_GENERIC, 5, "buttons/button10.wav")
            --return
        end
        if (self.group.list[group]) then
            if (self.sql:UpdateByid("faction_menubar", "steamid", plyinfo.steamid, {groupid = self.group.list[group].id})) then
                self.menubar = self.sql:SelectWhere("faction_menubar", "factionid", plyinfo.factionid)
            end
            hook.Run("FactionToCL")
        end
    end
end

hook.Add("FactionToCL", Faction, function() end)

--Faction:ChangeGroup(player.GetAll()[1], "SuperAdmin", true)
--Faction:JoinByid(player.GetBots()[1], 5)
--print(Faction:getName(2))

-- local mPly = {}

-- function mPly:new(name, steamid, money)
--     local obj = {}
--     setmetatable(obj, self)
--     self.__index = self
--     obj.name = name
--     obj.steamid = steamid
--     obj.money = money
--     obj.is = true
--     return obj
-- end

-- function mPly:Nick()
--     return self.name
-- end

-- function mPly:SteamID()
--     return self.steamid
-- end

-- function mPly:GetNWInt(str)
--     if (str == "money") then
--         return self.money
--     end
-- end

-- function mPly:getId()
--     return Faction.sql:SelectVal("libk_player", "id", "player", self:SteamID())
-- end

-- local test1 = mPly:new("ABTTEX", "STEAM_0:1:68948284", 123123)
-- local test2 = mPly:new("shangguan", "STEAM_0:1:123075291", 123113)


--PrintTable( Faction:getGang(player.GetAll()[1]:getId()):getColor() )
--Faction:new(player.GetAll()[1], "测试帮派", Color(255, 0, 0))
--Faction:new(player.GetBots()[1], "测试帮派2", Color(255, 255, 0))
--Faction.gang[1]:JoinByid(test2, "4")
--Faction:JoinByid(test1, "2")
--Faction.gang[1]:ExitByid(test1, "1")
--Faction.gang[1]:ExitByid(test2, "4")
--Faction.sql:DeleteByid("faction_menubar", "steamid", test1:SteamID(), { cols = "factionid", vals = "1" })
--print(Faction.gang[1]:getName())
--Faction:Drop("1")



--PrintTable(Faction)
--Faction.gang = nil
--Faction.JoinBytid(test2,1)
--PrintTable(Faction.gang)