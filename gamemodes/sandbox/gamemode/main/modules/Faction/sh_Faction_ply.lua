local ply = FindMetaTable("Player")

if (SERVER) then
    function ply:getId()
        return Faction.sql:SelectVal("libk_player", "id", "player", self:SteamID())
    end

    function ply:hasGang()
        if Faction.sql:SelectVal("faction_menubar", "id", "id", self:getId()) == self:getId() then
            return true
        end
        return false
    end

end

function ply:GetMenubarInfo()
    if (Faction:GetAll()) then
        for k, v in pairs(Faction:GetAll()) do
            if (v.menubar) then
                for _, info in pairs(v.menubar) do
                    if (info.steamid == self:SteamID()) then
                        return info
                    end
                end
            end
        end
    end
    return -1
end

function ply:GetGang()
    if (Faction.gang) then
        for k, v in pairs(Faction.gang) do
            if (v.menubar) then
                for _, info in pairs(v.menubar) do
                    if (info.steamid == self:SteamID()) then
                        return v
                    end
                end
            end
        end
    end
    return nil
end

function ply:GetGangId()
    local plyinfo = self:GetMenubarInfo()
    if (plyinfo != -1) then
        return plyinfo.factionid
    end
    return nil
end