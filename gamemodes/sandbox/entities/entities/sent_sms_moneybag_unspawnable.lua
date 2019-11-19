
-- Money Printer's Money Bag for Sandbox Money System
-- Version: 1.0

AddCSLuaFile()

--DEFINE_BASECLASS( "base_anim" )	

ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName		= "Money Bag"
ENT.Author			= "KRisU"
ENT.Information		= "Money Bag"
--ENT.Category		= "Sandbox Money System"

ENT.Editable	= false
ENT.Spawnable	= false
ENT.AdminOnly	= true


function ENT:SpawnFunction( ply, eyetrace, ClassName )

	if ( !eyetrace.Hit ) then return end
	
	local SpawnPos = eyetrace.HitPos + eyetrace.HitNormal * 16
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end


--[[---------------------------------------------------------
   Name: Initialize
-----------------------------------------------------------]]

function ENT:Initialize()

	if ( SERVER ) then

		self:SetModel( "models/props_junk/garbage_bag001a.mdl" )
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
	
		local Max = (math.ceil((GetPaydayAmount()/10)+(activator:GetNWInt( "bountyFame" )/15))+math.floor(math.random(3,9)))
		
		if (Max >= GetPaydayAmount()*0.75) then
			Max = (math.ceil(GetPaydayAmount()/10)+math.floor(math.random(4,25)))
		end
		
		if (Max < 10) then 
			Max = 10
		end
		
		local money = math.random(5, Max)
	
		activator:roi_interact(0, 0.01)
		activator:fame_interact(1, 1)
		activator:money_give(money)
		
		if (activator:GetInfoNum( "money_notifications", 1 ) == 1) then -- Retrieve clientsided variable value and check if it is 1 (true).	
			activator:PrintMessage( HUD_PRINTTALK , ">> 获得 " .. money .. " $的假币!")
		end
		
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
	for key, ply in pairs(player.GetHumans()) do
		ply:money_take_absolute(1)
	end
end

-- END OF FILE --