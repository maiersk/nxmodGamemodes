AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel( "models/props_junk/cardboard_box003a.mdl" )
    self:PhysicsInit( SOLID_VPHYSICS )          --初始化的物理对象实体使用当前的模型
    self:SetMoveType( MOVETYPE_VPHYSICS )       --设置实体移动类型
    self:SetSolid(SOLID_VPHYSICS)               --设置坚固实体
	self:SetNWInt("amount", 0)                  --量
	self:SetNWInt("distance", 512)              --距离
    self:SetNWEntity( "picker", nil )           --选择器
    self:SetPos(self:GetPos() + Vector(0,0,20))
	self.jailWall = true
	self.CanUse = true
	self.RemovingTime = 60
end

function ENT:AcceptInput(name, activator, caller)	

end

function ENT:Touch(hitEnt)
end 

function ENT:OnRemove()

end