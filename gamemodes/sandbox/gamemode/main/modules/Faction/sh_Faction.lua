Faction = Faction or {}
Faction.gang = Faction.gang or {}

Faction.CREATEGANGMONEY = 10000

if (SERVER) then
    --同步到客户端
    hook.Add("FactionToCL", "faction_sendtocl", function()
        local ply = player.GetAll()[1]
        
        NetOperating.Send(ply, "faction_tocl_senddata", function()
            net.WriteTable(Faction:GetAll())
        end)
    end)

    hook.Add("PlayerInitialSpawn", "PlayerInitialSpawn_faction_tocl_data", function( ply )
        NetOperating.Send(ply, "faction_tocl_senddata", function()
            net.WriteTable(Faction:GetAll())
        end)
    end)



    --接收客户端操作
    NetOperating.AddReceive("faction_cl_cgroup", function(len, ply)
        local data = net.ReadTable()
        if (data.plyid && data.group && data.fid) then
            local faction = Faction:getGang(data.fid)
            PrintTable(faction:getPlyinfoById(data.plyid))
            faction:ChangeGroup(data.plyid, data.group, ply)
        end
    end)

    NetOperating.AddReceive("faction_cl_kick", function(len, ply)
        local data = net.ReadTable()
        if (data.plyid && data.fid) then
            local faction = Faction:getGang(data.fid)
            faction:KickMenubar(data.plyid, ply)
        end
    end)

    NetOperating.AddReceive("faction_cl_setcolor", function()
        local data = net.ReadTable()
        if (data) then
            local faction = Faction:getGang(data.fid)
            faction:SetColor(data.col)
        end
    end)

    NetOperating.AddReceive("faction_cl_setname", function()
        local data = net.ReadTable()
        if (data) then
            Faction:SetName(data.str, data.fid)
        end
    end)

    NetOperating.AddReceive("faction_cl_savemoeny", function(len, ply)
        local data = net.ReadTable()
        if (data) then
            Faction:SaveMoney(ply, data.count, data.fid)
        end
    end)

    NetOperating.AddReceive("faction_cl_takemoeny", function(len, ply)
        local data = net.ReadTable()
        if (data) then
            Faction:TakeMoeny(ply, data.count, data.fid)
        end
    end)

    NetOperating.AddReceive("faction_cl_drop", function(len, ply)
        local data = net.ReadTable()
        if (data) then
            local faction = Faction:getGang(data.fid)
            faction:Drop(data.plyid, data.fid, ply)
        end
    end)

    NetOperating.AddReceive("faction_cl_joinbyid", function(len, ply)
        local data = net.ReadTable()
        if (data) then
            local ply = player.GetBySteamID(data.steamid)
            local faction = Faction:getGang(data.fid)
            faction:JoinByid(ply, nil, data.group)
        end
    end)

    NetOperating.AddReceive("faction_cl_exitbyid", function(len, ply)
        local data = net.ReadTable()
        if (data) then
            Faction:ExitByid(data.plyid, data.fid)
        end
    end)



    NetOperating.AddReceive("Derma_Query_invite_plytoGang", function(len, ply)
        local data = net.ReadTable()
        if (data) then
            local sltply = player.GetBySteamID(data.steamid)
            if (ply:hasGang()) then
                NetOperating.Send(sltply, "Derma_Query_snedtocl", function()
                    net.WriteTable({fName = data.fName, opply = ply})
                end)
            else
                notice.Add(ply, "已加入帮派无法邀请", notice.NOTIFY_GENERIC, 5, "buttons/button10.wav")
            end
        end
    end)

    NetOperating.AddReceive("factoin_createmenu_create", function(len, ply)
        local data = net.ReadTable()
        if (data) then
            if (!ply:money_take( Faction.CREATEGANGMONEY )) then 
                notice.Add(ply, "你不够余额无法创建帮派", notice.NOTIFY_GENERIC, 5, "buttons/button10.wav") 
                return 
            end
            Faction:new(ply, data.name, Color(data.color.r, data.color.g, data.color.b))
            notice.Add(ply, "创建 " .. data.name .. " 帮派成功", notice.NOTIFY_GENERIC, 5, "buttons/button10.wav")
        end
    end)
end



if (CLIENT) then
    --接收帮派数据转为对象
    NetOperating.AddReceive("faction_tocl_senddata", function()
        local data = net.ReadTable()
        Faction.gang = Faction:HandleObj(data)
    end)
end



function Faction:GetAll()
    return self.gang
end

function Faction:getDomain()
    if (Domain.data) then
        local tbl = {}
        for k, v in pairs(Domain.data) do
            if (v.factionid == self.id) then
                table.insert(tbl, v)
            end
        end
        return tbl
    end
end

function Faction:getGang(id)
    for k, v in pairs(self.gang) do
        if (v.id == tostring(id)) then
            return v
        end
    end
    return false
end

function Faction:getMenubar()
    return self.menubar
end

function Faction:getMenubarInfo(ply)
    if (ply) then
        for k, v in pairs(self.menubar) do
            if (v.steamid == ply:SteamID()) then
                return v
            end
        end
    end
    return false
end

function Faction:getPlyinfoById(id)
    if (id) then
        for k, v in pairs(self.menubar) do
            print(v.id, id)
            if (v.id == tostring(id)) then
                return v
            end
        end
    end
    return false
end

function Faction:getColor()
    if (self.color) then
        return util.JSONToTable(self.color)
    end
    return {}
end

function Faction:getName(id)
    if (id) then
        return self:getGang(id):getName() or ""
    end
    if (self.name) then
        return self.name
    end
    return ""
end



--Client function
if CLIENT then
    function Faction:JoinByid(steamid, group)
        NetOperating.SendToServ("faction_cl_joinbyid", { steamid = steamid, group = group, fid = self.id })
    end

    function Faction:ExitByid(plyid)
        NetOperating.SendToServ("faction_cl_exitbyid", { plyid = plyid, fid = self.id})
    end

    function Faction:KickMenubar(id)
        NetOperating.SendToServ("faction_cl_kick", { plyid = id, fid = self.id })
    end

    function Faction:ChangeGroup(id, group)
        NetOperating.SendToServ("faction_cl_cgroup", { plyid = id, group = group, fid = self.id })
    end

    function Faction:SetColor(col)
        NetOperating.SendToServ("faction_cl_setcolor", {col = col, fid = self.id})
    end

    function Faction:SetName(str)
        NetOperating.SendToServ("faction_cl_setname", {str = str, fid = self.id})
    end

    function Faction:SaveMoney(count)
        NetOperating.SendToServ("faction_cl_savemoeny", {count = count, fid = self.id})
    end

    function Faction:TakeMoeny(count)
        NetOperating.SendToServ("faction_cl_takemoeny", {count = count, fid = self.id})
    end

    function Faction:Drop(plyid)
        NetOperating.SendToServ("faction_cl_drop", {plyid = plyid, fid = self.id})
    end
end

--PrintTable(Faction.gang)