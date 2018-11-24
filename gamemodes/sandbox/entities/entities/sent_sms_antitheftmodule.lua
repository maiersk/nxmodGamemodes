
-- Anti-Theft Module for Sandbox Money System
-- Version: 1.0

AddCSLuaFile()

--DEFINE_BASECLASS( "base_anim" )	

ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName		= "Anti-Theft"
ENT.Author			= "KRisU"
ENT.Information		= "Makes sure you'll be unrobbable in the next 60 seconds!"
ENT.Category		= "Money"

ENT.Editable	= false
ENT.Spawnable	= true
ENT.AdminOnly	= false
ENT.Owner 		= nil

-- This is the spawn function. It's called when a client calls the entity to be spawned.
-- If you want to make your SENT spawnable you need one of these functions to properly create the entity
--
-- ply is the name of the player that is spawning item
-- eyetrace is the trace from the player's eyes 

function ENT:SpawnFunction( ply, eyetrace, ClassName )

	if ( !eyetrace.Hit ) then return end
	
	local SpawnPos = eyetrace.HitPos + eyetrace.HitNormal * 16
	
	Owner = ply
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	ent:SetColor( Color( 200, 200, 255, 255 ) )
	
	return ent
	
end

--[[---------------------------------------------------------
   Name: Initialize
-----------------------------------------------------------]]

function ENT:Initialize()

	if ( SERVER ) then

		self:SetModel( "models/Items/car_battery01.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		 
		local phys = self:GetPhysicsObject()
		
		if (phys:IsValid()) then
			phys:SetMass(phys:GetMass()*2) -- Double the mass of the ball
			phys:Wake()
		end
		
	else

		self.Color = Color( 255, 255, 255, 255 )
		
	end
	
end

if ( CLIENT ) then

	function ENT:Draw()		
		--self:DrawEntityOutline(1)
		self.Entity:DrawModel()
	end

end


--[[---------------------------------------------------------
   Name: OnTakeDamage
-----------------------------------------------------------]]

function ENT:OnTakeDamage( dmginfo )

	-- React physically when shot/getting blown
	self:TakePhysicsDamage( dmginfo )
	
end	


--[[---------------------------------------------------------
   Name: Use
-----------------------------------------------------------]]

function ENT:Use( activator, caller )

	self:Remove()
	
	if ( activator:IsPlayer() ) then
	
		-- Give the collecting player some money and log it for them in console.
		activator:SetNWBool( "antitheftEq", true )
		activator:roi_interact(0, 0.01)
		activator:fame_interact(1, 13)
		activator:PrintMessage( HUD_PRINTTALK , ">> 安全第一！ 你不会在接下来的250秒内被抢劫!" )
		
		timer.Simple( 249, function() 
			activator:SetNWBool( "antitheftEq", false ) 
			activator:PrintMessage( HUD_PRINTTALK , ">> 防盗技能快耗尽了!" )
		end)
		
	end

end


--[[---------------------------------------------------------
   Others
-----------------------------------------------------------]]

function ENT:PhysicsCollide( data, physobj )

end

function ENT:Touch(ent)

end

function ENT:OnDuplicated( tab )
	Owner:money_take_absolute(5)
end

-- END OF FILE --