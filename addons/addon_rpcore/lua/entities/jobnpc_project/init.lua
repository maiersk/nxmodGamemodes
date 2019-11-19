AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
--模块化读取table--------------------------------------------------------------------------
items = items or {}

items.projectTable = {}

function items.AddprojectTable(data)
	data.value = data.value or {}
	items.projectTable[data.name] = data
end

function items.RemoveprojectTable(name)
	items.projectTable[name] = nil
end

for k, name in pairs(file.Find("lua/entities/jobnpc_project/items/*.lua", "GAME")) do
	local path = "entities/jobnpc_project/items/" .. name
	include(path)
	AddCSLuaFile(path)
end
-------------------------------------------------------------------------------------------
include('shared.lua')

function ENT:Initialize()

	self:SetModel( projectNPCConfig.NpcModel )
	self:SetHullType( HULL_HUMAN );
	self:SetHullSizeNormal();
	self:SetSolid( SOLID_BBOX )
	self:CapabilitiesAdd(CAP_ANIMATEDFACE)
	self:CapabilitiesAdd(CAP_TURN_HEAD)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetBloodColor(BLOOD_COLOR_RED)

	self:SetMoveType( MOVETYPE_STEP )

	self:SetMaxYawSpeed(100)

end

function ENT:OnTakeDamage()
	return false
end


util.AddNetworkString( "Buttonflow" )
util.AddNetworkString( "project_NPCPANEL" )		--需每个npc不一样网络信息的名字

function ENT:AcceptInput( name, activator, caller )
	if name == "Use" and caller:IsPlayer() then

		self:EmitSound( projectNPCConfig.SoundWelcome, 50) 
	net.Start("project_NPCPANEL")				--需每个npc不一样网络信息的名字

	net.Send(caller)

  end
end

concommand.Add("project_tool", function(ply, command, arguments)
	if !arguments then return end
    data = data or {}
    local type = table.concat(arguments, " ")
	local data = items.projectTable[type]
	if !data then return end
    PrintTable(data)
    print("is ok !!!")
	if data.level then
		if (tonumber(ply:GetNWInt("level" .. "_" .. ply:GetUserGroup())) < data.level) then return end
		if !data.class then return end
		
		ply:Give(data.class) 

	end

end)