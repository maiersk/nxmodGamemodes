AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
ENT.PrintName = "Hotdog"

function ENT:Initialize()
	self:SetModel( "models/food/hotdog.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )

	local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use(activator, caller)
	if IsValid(caller) and caller:IsPlayer() then
		local hunger = caller:GetNWFloat("shm_hunger")
		local value = 15
		if (hunger >= 100-value) then
			caller:SetNWFloat("shm_hunger",100)
		else
			hunger = hunger + value
			caller:SetNWFloat("shm_hunger",hunger)
		end
		self:Remove()
	end
end