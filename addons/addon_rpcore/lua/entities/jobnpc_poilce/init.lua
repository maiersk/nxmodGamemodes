AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
--模块化读取table--------------------------------------------------------------------------
items = items or {}

items.poilceTable = {}

function items.AddpoilceTable(data)
	data.value = data.value or {}
	items.poilceTable[data.name] = data
end

function items.RemovepoilceTable(name)
	items.poilceTable[name] = nil
end

for k, name in pairs(file.Find("lua/entities/jobnpc_poilce/items/*.lua", "GAME")) do
	local path = "entities/jobnpc_poilce/items/" .. name
	include(path)
	AddCSLuaFile(path)
end
-------------------------------------------------------------------------------------------
include('shared.lua')

function ENT:Initialize()

	self:SetModel( poilceNPCConfig.NpcModel )
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
util.AddNetworkString( "poilce_NPCPANEL" )		--需每个npc不一样网络信息的名字

function ENT:AcceptInput( name, activator, caller )
	if name == "Use" and caller:IsPlayer() then

		self:EmitSound( poilceNPCConfig.SoundWelcome, 50) 
	net.Start("poilce_NPCPANEL")				--需每个npc不一样网络信息的名字

	net.Send(caller)

  end
end