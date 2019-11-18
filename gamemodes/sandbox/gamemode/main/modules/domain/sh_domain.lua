Domain = Domain or {}
Domain.data = Domain.data or {}

--setting domain
Domain.occupytime = 20

if (SERVER) then  

    hook.Add("DomainToCL", "domain_sendtocl", function()
        Domain:HandleData()
        local ply = player.GetAll()[1]
        
        NetOperating.Send(ply, "domain_tocl_senddata", function()
            net.WriteTable(Domain.data)
        end)
       
    end)

    --初始化_读取sql数据处理
    function Domain:HandleData()
        Domain.data = Domain.sql:SelectAll("domain")

        local function HandleJsonPos(data)
            if (data && type(data) == "string") then
                data = util.JSONToTable(data)
                if (table.Count(data)) then
                    for k, v in pairs(data) do
                        data[k] = string.Split(v, " ")
                        data[k] = Vector(data[k][1], data[k][2], data[k][3])
                    end
                    return data
                end
            end
            return data
        end
        
        if (Domain.data) then
            for k, v in pairs(Domain.data) do
                v.flag = Domain.sql:SelectWhere("domain_flag", "id", v.flagid)[1]
            end
        
            for k, cont in pairs(Domain.data) do
                
                if (cont.position) then
                    cont.position = HandleJsonPos(cont.position)
                end
                if (cont.flag.position) then
                    cont.flag.position = HandleJsonPos(cont.flag.position)
                end
                if (cont.color && type(cont.color) == "string") then
                    cont.color = util.JSONToTable(cont.color)
                end
            end
        end
    end

    --初始化 生成保存了的领地旗帜
    hook.Add("InitPostEntity", "InitPostEntity_domain_initflag", function()
        Domain:HandleData()

        if (Domain.data) then
            for k, v in pairs(Domain.data) do
                if (v.flag.position.pos) then
                    
                    local ent = Domain.flag:CreateFlagentity(v.flag.position.pos)
                    if (v.factionid != -1) then
                        local faction = Faction:getGang(v.factionid)
                        if (faction) then
                            local col = faction:getColor()
                            ent:SetFlagColor(Color(col.r, col.g, col.b, col.a))
                        end
                    end
                    Domain.sql:UpdateByid("domain_flag", "id", v.flagid, {entindex = ent:EntIndex()})
                end
            end
        end
    end)

    hook.Add("PlayerInitialSpawn", "PlayerInitialSpawn_domain_tocl_data", function( ply )
        NetOperating.Send(ply, "domain_tocl_senddata", function()
            net.WriteTable(Domain.data)
        end)
    end)

    --接收客户端操作

    NetOperating.AddReceive("domain_cl_abandon", function()
        local data = net.ReadTable()
        print(data.name)
        if (data.name) then
            Domain:Abandon(Domain:IdByName(data.name))
        end
    end)

end

if (CLIENT) then

    NetOperating.AddReceive("domain_tocl_senddata", function(len, ply)
        Domain.data = net.ReadTable()
        PrintTable(Domain.data)
    end)

    PrintTable(Domain.data)

end



function Domain:GetByID(id)
    for k, v in pairs(Domain.data) do
        if (v.id == tostring(id)) then
            return Domain.data[k]
        end
    end
end