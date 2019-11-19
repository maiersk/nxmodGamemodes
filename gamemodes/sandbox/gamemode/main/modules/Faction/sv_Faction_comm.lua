Faction = Faction or {}
Faction.comm = Faction.comm or {}
Faction.comm.list = Faction.comm.list or {}

function Faction.comm:Init()
    hook.Add("PlayerSay", "Faction_comm", function(ply, text)
        local text = string.lower(text)
        local text = string.Explode(" ", text)
        
        if self.list then
            for k, funs in pairs(self.list) do
                if text[1] == k then
                    funs(ply, text)
                    return ""
                end
            end
        end
    end)
end

function Faction.comm:Add(name, funs)
    self.list[name] = funs
end

Faction.comm:Add("!showgang", function(ply, text)
    --PrintTable(Faction:GetAll())
    local faction = ply:GetGang()
    if (faction) then
        NetOperating.Send(ply, "faction_menu", function()
            net.WriteTable({ 
                group = Faction.group:GetAll(),
                owner = Faction.sql:SelectVal("libk_player", "name", "player", faction.ownerid)
            })
        end)
    else
        notice.Add(ply, "你还没加入帮派，无法打开面板", notice.NOTIFY_GENERIC, 5, "buttons/lever1.wav")
    end
end)

Faction.comm:Add("!creategang", function(ply, text)
    local faction = ply:GetGang()
    if (!faction) then
        NetOperating.Send(ply, "faction_createmenu", function()
            
        end)
    end
end)

Faction.comm:Add("!joingang", function(ply, text)
    if text[2] then
        Faction:JoinByid(ply, text[2])
    end
end)

Faction.comm:Add("!exitgang", function(ply, text)
    if text[2] then
        Faction:ExitByid(ply, text[2])
    end
end)

Faction.comm:Add("!dropgang", function(ply, text)
    if text[2] then
        Faction:Drop(tostring(text[2]))
    end
end)