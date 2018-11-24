
-- Money Printer for Sandbox Money System
-- Note from KRisU: Based on the code of DarkRP money_printer, Explosive Cars SENTs and GMod Bouncy Ball. No credits taken!
-- Version: 1.0

AddCSLuaFile()

--DEFINE_BASECLASS( "base_anim" )	

ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName		= "Money Printer"
ENT.Author			= "KRisU"
ENT.Information		= "Makes sure you'll not run outta cash... in prison!"
ENT.Category		= "Money"

ENT.Editable		= false
ENT.Spawnable		= true
ENT.AdminOnly		= false

-- This is the spawn function. It's called when a client calls the entity to be spawned.
-- If you want to make your SENT spawnable you need one of these functions to properly create the entity
--
-- ply is the name of the player that is spawning item
-- eyetrace is the trace from the player's eyes 

local Owner = nil

function ENT:SpawnFunction( ply, eyetrace, ClassName )

	if ( !eyetrace.Hit ) then return end
	
	Owner = ply
	
	local SpawnPos = eyetrace.HitPos + eyetrace.HitNormal * 16
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

--[[---------------------------------------------------------
   Sound
-----------------------------------------------------------]]

function ENT:StartSound()
    self.sound = CreateSound(self, Sound("ambient/levels/labs/equipment_printer_loop1.wav"))
    self.sound:SetSoundLevel(50)
    self.sound:PlayEx(1, 100)
end

--[[---------------------------------------------------------
   Name: Initialize
-----------------------------------------------------------]]

function ENT:Initialize()

	if ( SERVER ) then

		self:SetModel( "models/props_c17/cashregister01a.mdl" )
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )
		 
		local phys = self:GetPhysicsObject()
		
		if (phys:IsValid()) then
			phys:SetMass(math.floor(phys:GetMass()*2))
			phys:Wake()
		end
		
		self.StartHealth = 40
		self:SetMaxHealth(self.StartHealth)
		self:SetHealth(self.StartHealth)

		self.burning = false
		
		self.OverheatChance = 30
		self.MinTimer = 16
		self.MaxTimer = 49
				
		self:StartSound()
		timer.Simple(math.ceil(math.random(self.MinTimer, self.MaxTimer)), function() PrintMoney(self) end)

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

if (SERVER) then

	--[[---------------------------------------------------------
	   Damage / Removal
	-----------------------------------------------------------]]

	function ENT:Destroy() -- VALID

		local randomfactor = math.random()
		local effectdata = EffectData()
		
		effectdata:SetStart(self:GetPos())
		effectdata:SetOrigin(self:GetPos())
		effectdata:SetScale(1)
		
		if (randomfactor >= 0.1) then
			util.Effect("Explosion", effectdata)
		else
			util.Effect("cball_explode", effectdata)
		end
		
		if (Owner:GetInfoNum( "money_notifications", 1 ) == 1) then
			Owner:PrintMessage( HUD_PRINTTALK, ">> 假钱打印机爆炸了!" )
		end
		
	end

	function ENT:Fireball()

		if not self:IsOnFire() then 
			self.burning = false
			return
		end
		
		local dist = math.random(20, 280) -- Explosion radius
		
		self:Destroy()
		
		for k, v in pairs(ents.FindInSphere(self:GetPos(), dist)) do
			if not v:IsPlayer() and not v:IsWeapon() and v:GetClass() ~= "predicted_viewmodel" and not v:GetClass() == self:GetClass() then
				v:Ignite(math.random(4, 16), 0)
			elseif v:IsPlayer() then
				v:TakeDamage( (v:GetPos():Distance(self:GetPos()) / dist * 100), self, self)
			end
		end
		
		self:Remove()
		
	end

	function ENT:BurstIntoFlames()
	
		if (Owner:GetInfoNum( "money_notifications", 1 ) == 1) then
			Owner:PrintMessage( HUD_PRINTTALK, ">> 假钱打印机过热!" )
		end
			
		self.burning = true
		local burntime = math.random(5, 15)
		self:Ignite(burntime, 0)
		timer.Simple(burntime, function() self:Fireball() end)
		
	end

	function ENT:OnTakeDamage( dmginfo )

		self:TakePhysicsDamage( dmginfo )

		if self.burning then
			return
		end
		
		if (self:Health() <= (self.StartHealth / 2)) then
			local randomfactor = math.random(1, 10)
			if randomfactor < 1.5 then
				self:Destroy()
				self:Remove()
			elseif randomfactor < 3 then
				self:BurstIntoFlames()
			end
		end
		
		if dmginfo:IsExplosionDamage() and dmginfo:GetDamage() >= 50 then
			self:Destroy()
			self:Remove()
		end
		
		if self:Health() - dmginfo:GetDamage() <= 0 then
			self:Destroy()
			self:Remove()
		else
			self:SetHealth(self:Health() - dmginfo:GetDamage())
		end
		
	end

	--[[---------------------------------------------------------
	   Name: Use / Overtime / Think
	-----------------------------------------------------------]]

	function ENT:Use( activator, caller )

	end
	
	function ENT:PhysicsCollide( data, physobj )

	end

	function ENT:Touch(ent)

	end

	function PrintMoney( ent )
		
		if not IsValid(ent) then 
			return 
		end

		ent.sparking = true
		timer.Simple(4, function()
			if not IsValid(ent) then return end
			ent:CreateMoneyBag()
		end)
		
	end
	
	function ENT:CreateMoneyBag()

		if not IsValid(self) or self:IsOnFire() then return end
		
		if self.OverheatChance and self.OverheatChance > 1 then
			local overheatfactor = math.random(1, self.OverheatChance)
			if overheatfactor < 3 then 
				self:BurstIntoFlames() 
			end
		end
		
		if self.OverheatChance < 9 then
			if (Owner:GetInfoNum( "money_notifications", 1 ) == 1) then
				Owner:PrintMessage( HUD_PRINTTALK, ">> 钱打印机至关重要!" )
			end
		end
		
		local moneybag = ents.Create( "sent_sms_moneybag_unspawnable" )
		
		moneybag:SetPos( Vector(self:GetPos().x + 20, self:GetPos().y + 2, self:GetPos().z + 20) )
		moneybag:Spawn()
		moneybag:Activate()

		self.OverheatChance = (self.OverheatChance - 1)
		self.sparking = false
		
		timer.Simple(math.random(self.MinTimer, self.MaxTimer), function() PrintMoney(self) end)
		
	end
	
	function ENT:Think()

		if self:WaterLevel() >= 1 then
			--timer.Simple(1, function() 
				self:Destroy()
				self:Remove()
			--end)
			return
		end
		
		self:StartSound()
		
		if not self.sparking then 
			return 
		end

		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
		effectdata:SetMagnitude(1)
		effectdata:SetScale(1)
		effectdata:SetRadius(2)
		util.Effect("Sparks", effectdata)
		
	end

	--[[---------------------------------------------------------
	   Name: OnRemove
	-----------------------------------------------------------]]
	
	function ENT:OnRemove()

		if self.sound then
			self.sound:Stop()
		end
		
	end
	
	function ENT:OnDuplicated( tab )
		Owner:money_take_absolute(5)
	end

end

-- END OF FILE --