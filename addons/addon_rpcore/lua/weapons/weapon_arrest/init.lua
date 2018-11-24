AddCSLuaFile( "shared.lua" )
include('shared.lua')

SWEP.Weight			= 3
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= true

function SWEP:ShouldDropOnDie()
	return false
end