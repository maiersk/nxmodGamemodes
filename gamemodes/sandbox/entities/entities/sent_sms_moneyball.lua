
-- Note from KRisU: Basically, it is the default bouncy ball from Garry's Mod. So, yeah, no credits taken.
-- Version: 1.3

AddCSLuaFile() -- Mark file for client downloads

local BounceSound = Sound( "garrysmod/balloon_pop_cute.wav" )

DEFINE_BASECLASS( "base_anim" )	

ENT.PrintName		= "Money Ball"
ENT.Author			= "KRisU"
ENT.Information		= "Catch the ball and get free 250$!"
ENT.Category		= "Money"

ENT.Editable		= true
ENT.Spawnable		= true
ENT.AdminOnly		= true -- Leave it be.
ENT.RenderGroup 	= RENDERGROUP_TRANSLUCENT
ENT.Owner 			= nil
	

function ENT:SetupDataTables()

	self:NetworkVar( "Float", 0, "BallSize", { KeyName = "ballsize", Edit = { type = "Float", min=8, max=64, order = 1 } }  );
	self:NetworkVar( "Vector", 0, "BallColor", { KeyName = "ballcolor", Edit = { type = "VectorColor", order = 2 } }  );

end

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
		ent:SetBallSize(30)
	ent:Spawn()
	ent:Activate()
	
	return ent
	
end

--[[---------------------------------------------------------
   Name: Initialize
-----------------------------------------------------------]]

function ENT:Initialize()

	if ( SERVER ) then

		local size = self:GetBallSize() / 2;
	
		-- Use the helibomb model just for the shadow (because it's about the same size)
		self:SetModel( "models/Combine_Helicopter/helicopter_bomb01.mdl" )
		
		-- Don't use the model's physics - create a sphere instead
		self:PhysicsInitSphere( size, "metal_bouncy" )
		
		-- Wake the physics object up. It's time to have fun!
		local phys = self:GetPhysicsObject()
		if (phys:IsValid()) then
			phys:SetMass(phys:GetMass()*2) -- Double the mass of the ball
			phys:Wake()
		end
		
		-- Set collision bounds exactly
		self:SetCollisionBounds( Vector( -size, -size, -size ), Vector( size, size, size ) )

		self:SetBallColor( Vector( 0.5, 0.5, 0.5 ) )

		self:NetworkVarNotify( "BallSize", self.OnBallSizeChanged );
		
	else 
	
		self.LightColor = Vector( 0, 0, 0 )
	
	end
	
end

function ENT:OnBallSizeChanged( varname, oldvalue, newvalue )

	local delta = oldvalue - newvalue

	local size = self:GetBallSize() / 2;
	self:PhysicsInitSphere( size, "metal_bouncy" )
	self:SetCollisionBounds( Vector( -size, -size, -size ), Vector( size, size, size ) )

	self:PhysWake()

end

if ( CLIENT ) then

	local matBall = Material( "sprites/sent_sms_moneyball" )

	function ENT:Draw()
		
		local pos = self:GetPos()
		local vel = self:GetVelocity()

		render.SetMaterial( matBall )
		
		local lcolor = render.ComputeLighting( self:GetPos(), Vector( 0, 0, 1 ) )
		local c = self:GetBallColor()
		
		lcolor.x = c.r * (math.Clamp( lcolor.x, 0, 1 ) + 0.5) * 255
		lcolor.y = c.g * (math.Clamp( lcolor.y, 0, 1 ) + 0.5) * 255
		lcolor.z = c.b * (math.Clamp( lcolor.z, 0, 1 ) + 0.5) * 255
			
		render.DrawSprite( pos, self:GetBallSize(), self:GetBallSize(), Color( 255, 255, 255, 255 ) )
		
	end

end

--[[---------------------------------------------------------
   Name: PhysicsCollide
-----------------------------------------------------------]]

function ENT:PhysicsCollide( data, physobj )
	
	-- Play sound on bounce
	if ( data.Speed > 60 && data.DeltaTime > 0.2 ) then

		sound.Play( BounceSound, self:GetPos(), 75, math.random( 90, 120 ), math.Clamp( data.Speed / 150, 0, 1 ) )

	end
	
	-- Bounce like a crazy bitch, but less than Bouncy Ball
	local LastSpeed = math.max( data.OurOldVelocity:Length(), data.Speed )
	local NewVelocity = physobj:GetVelocity()
	NewVelocity:Normalize()
	
	LastSpeed = math.max( NewVelocity:Length(), LastSpeed )
	
	local TargetVelocity = NewVelocity * LastSpeed * 0.67 -- Bigger the float multipler, bigger the speed with every bounce and smaller falloff of velocity.
	
	physobj:SetVelocity( TargetVelocity )
	
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
		activator:money_give(250)
		activator:roi_interact(1, 0.02)
		activator:fame_interact(1, 29)
		activator:PrintMessage( HUD_PRINTTALK , ">> 使用加钱球加了 250$ !" )
		
	end

end

function ENT:OnDuplicated( tab )
	Owner:money_take_absolute(5)
end

-- END OF FILE --