concommand.Add("jobnpc_menu", function(ply, command, args)

    umsg.Start("jobnpc_createmenu", ply)
        umsg.Vector(ply:GetEyeTrace().HitPos)
    umsg.End()
    
end)

concommand.Add("jobnpc_srcmenu", function(ply, command, args)

    umsg.Start("jobnpc_srcmenu", ply)
        --umsg.Vector(ply:GetEyeTrace().HitPos)
    umsg.End()
    
end)

concommand.Add("jobnpc_tool", function(ply, command, arguments)
	if !arguments then return end
    data = data or {}
    local type = table.concat(arguments, " ")
	local data = items.citizenTable[type]
	if !data then return end
    PrintTable(data)
    print("is ok !!!")
	if data.level then
		if (tonumber(ply:GetNWInt("level" .. "_" .. ply:GetUserGroup())) < data.level) then return end
		if !data.class then return end
		
		ply:Give(data.class) 

	end

end)