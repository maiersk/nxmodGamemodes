Domain = Domain or {}
Domain.data = Domain.data or {}

function Domain:Load()
    self.sql:Init()

end

function Domain:new(hitpos, name, pos, description, color, factionid)
    if (type(pos) == "table" && (pos[1] && pos[2])) then
        local flagid = self.flag:CreateFlag(name, {pos = hitpos})
        if (flagid != -1) then
            if (self.sql:InsertTo("domain", {
                    flagid = flagid,
                    name = name,
                    position = "{\"pos1\":\"" .. tostring(pos[1]) .. "\", \"pos2\":\"" .. tostring(pos[2]) .. "\"}",
                    description = description,
                    color = util.TableToJSON(color),
                    factionid = factionid,
                })) then
                hook.Run("DomainToCL")
            end
        end
    end
end

function Domain:Drop(id)
    local flagid = self.sql:SelectVal("domain", "flagid", "id", id)

    self.flag:DeleteFlagentity(flagid)
    if (self.sql:DeleteByid("domain", "id", id)) then
        hook.Run("DomainToCL")
    end
    
end

function Domain:Occupy(gangid, domain)
    local faction = Faction:getGang(gangid)
    if (faction && domain.id) then
        if (self.sql:UpdateByid("domain", "id", domain.id, { factionid = faction.id })) then
            print("ok ！")
            local ent = ents.GetByIndex(domain.flag.entindex)
            local col = faction:getColor()

            if (col && ent) then
                ent:SetFlagColor(Color(col.r, col.g, col.b, col.a))
            end
            hook.Run("DomainToCL")
        end
    end
end

function Domain:Abandon(domainid)
    local domain = self:GetByID(domainid)

    if (self.sql:UpdateByid("domain", "flagid", domain.flagid, { factionid = "-1" })) then
        local ent = ents.GetByIndex(domain.flag.entindex)
        ent:SetFlagColor(Color(255, 255, 255, 255))
    end
    hook.Run("DomainToCL")
end

function Domain:IdByName(name)
    local id = self.sql:SelectVal("domain", "id", "name", name)
    if (id) then
        return id
    end
    return -1
end

function Domain:isExist()

end

hook.Add("DomainToCL", Domain, function() end)

--hook.Run("DomainToCL")

--Domain:Abandon("1")
--PrintTable(Domain.data)

--Domain:new(1, "test", {Vector(0,0,0), Vector(-11745, -4950, 35)}, "test this domain function", 1)
--Domain:Drop(7)

-- local split = string.Split(tostring(Vector(-11745, -4950, 35)), " ")
-- PrintTable(split)
-- print(table.concat(split, ","))
-- print(split)

-- local json = util.TableToJSON( {pos = tostring(Vector(-11745, -4950, 35))} )
-- print(json)

-- local totable = util.JSONToTable(json)
-- PrintTable(totable)
-- Domain.sql:InsertTo("domain", {
--     name = "test1",
--     position = "{\"pos1\":\"[" .. tostring(Vector(0,0,0)) .. "]\", \"pos2\":" .. tostring(Vector(-11745, -4950, 35)) .. "}",
--     factionid = 0,
-- })