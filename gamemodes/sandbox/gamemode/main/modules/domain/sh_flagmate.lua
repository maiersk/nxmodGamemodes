Domain = Domain or {}
Domain.flag = Domain.flag or {}

if (SERVER) then

    function Domain.flag:GetFlag()
        return Domain.sql:SelectAll("domain_flag")
    end

    function Domain.flag:CreateFlagentity(pos)
        local ent = ents.Create("domain_flag_rod")
        ent:SetPos(pos + Vector(0,0,100))
        ent:Spawn()

        return ent
    end

    function Domain.flag:DeleteFlagentity(id)
        local flagIdx = Domain.sql:SelectVal("domain_flag", "entindex", "id", id)
        if (flagIdx) then
            local ent = ents.GetByIndex(flagIdx)
            if (Domain.sql:DeleteByid("domain_flag", "id", id)) then
                ent:Remove()
            end
        end
    end

    function Domain.flag:CreateFlag(name, data)
        
        local ent = self:CreateFlagentity(data.pos)

        if (Domain.sql:InsertTo("domain_flag", {
            name = name,
            entindex = ent:EntIndex(),
            position = "{\"pos\":\"" .. tostring(data.pos) .. "\"}",
        })) then
            return Domain.sql:SelectVal("domain_flag", "id", "name", name)
        else
            ent:Remove()
            return -1
        end
        
    end

end

function Domain.flag:GetDomain(flag)
    local entidx = flag:EntIndex()

    for k, v in pairs(Domain.data) do
        if (tonumber(v.flag.entindex) == tonumber(entidx)) then
            return Domain.data[k]
        end
    end
    return nil
end