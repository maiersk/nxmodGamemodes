SWEP.PrintName			= "逮捕"
	SWEP.DrawAmmo			= false
	SWEP.DrawCrosshair		= true
	SWEP.ViewModelFOV		= 55
	SWEP.ViewModelFlip		= false
	SWEP.CSMuzzleFlashes	= true
	SWEP.Slot = 1
	SWEP.SlotPos		= 2


SWEP.Author		= "NxMod"
SWEP.Purpose		= "arrest"
SWEP.Instructions	= "鼠标左键对嫌疑人进行逮捕"


SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.ViewModel			= "models/weapons/v_pistol.mdl"
SWEP.WorldModel			= "models/weapons/w_pistol.mdl"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"
SWEP.Category = "nxrp"  
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

local ShootSound = Sound( "Airboat.FireGunRevDown" )
local selected_npcs_movement = {}
/*---------------------------------------------------------
	Initialize
---------------------------------------------------------*/
function SWEP:Initialize()
end

/*---------------------------------------------------------
	PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
local trace = self.Owner:GetEyeTrace()
self:EmitSound( ShootSound )
local effectdata = EffectData()
effectdata:SetOrigin( trace.HitPos )
effectdata:SetStart( self.Owner:GetShootPos() )
effectdata:SetAttachment( 1 )
effectdata:SetEntity( self.Weapon )
util.Effect( "ToolTracer", effectdata )
if SERVER then
  local him = trace.Entity
  local crime, data = nxrp.GetCrime(him)
  print(him)
  nxrp.SetCrime( him, { "偷了" .. him:Nick() .. "身上的" .. 123 .. "$" } )
  PrintTable( nxrp.Crime )
  if him:IsPlayer() or him:IsBot() then
    if crime and him:GetPos():Distance(self:GetPos()) < 60 then
      --self.Owner
      him:SetPos( Vector( 815, 831, -149 ) )
      timer.Simple(2, function() him:SetPos( Vector( 354,931,-150 ) ) end)
    end
  end
  --[[
  if (selected_npcs_movement[self:GetOwner()] == nil) then selected_npcs_movement[self:GetOwner()] = {} end
  if (!trace.Entity:IsValid() || !trace.Entity:IsNPC()) then return true end

  if (selected_npcs_movement[self:GetOwner()][trace.Entity] == nil) then
    selected_npcs_movement[self:GetOwner()][trace.Entity] = trace.Entity
  else
    selected_npcs_movement[self:GetOwner()][trace.Entity] = nil
  end
  --]]
end

if CLIENT then
if (trace.Entity:IsNPC()) then
self.Owner:PrintMessage( HUD_PRINTTALK, "选择")

end
   return true
end
end

/*---------------------------------------------------------
	SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()
local trace = self.Owner:GetEyeTrace()
self:EmitSound( ShootSound )
local effectdata = EffectData()
effectdata:SetOrigin( trace.HitPos )
effectdata:SetStart( self.Owner:GetShootPos() )
effectdata:SetAttachment( 1 )
effectdata:SetEntity( self.Weapon )
util.Effect( "ToolTracer", effectdata )
if SERVER then
     if (selected_npcs_movement[self:GetOwner()] == nil) then selected_npcs_movement[self:GetOwner()] = {} end
     if (trace.HitWorld && !trace.HitSky && SERVER) then
        local action = SCHED_FORCED_GO_RUN
        for k, v in pairs(selected_npcs_movement[self:GetOwner()]) do
           if (v != nil && v:IsValid() && v:IsNPC()) then
              v:SetLastPosition( trace.HitPos )
              v:SetSchedule( action )
           end
        end
     end
   end
   return true
end

/*---------------------------------------------------------
	Reload
---------------------------------------------------------*/

function SWEP:Reload()
end 

/*---------------------------------------------------------
	Think
---------------------------------------------------------*/

function SWEP:Think()

end 