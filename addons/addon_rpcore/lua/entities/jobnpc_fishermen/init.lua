AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

function ENT:Initialize()

	self:SetModel( fishermenNPCConfig.NpcModel )
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
util.AddNetworkString( "fishermen_NPCPANEL" )		--需每个npc不一样网络信息的名字

function ENT:AcceptInput( name, activator, caller )
	if name == "Use" and caller:IsPlayer() then

		self:EmitSound( fishermenNPCConfig.SoundWelcome, 50) 
	net.Start("fishermen_NPCPANEL")				--需每个npc不一样网络信息的名字

	net.Send(caller)

  end
end