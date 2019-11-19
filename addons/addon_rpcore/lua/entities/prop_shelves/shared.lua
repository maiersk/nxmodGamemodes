ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName= "商店_货架"
ENT.Spawnable = true
ENT.AdminSpawnable = true
ENT.Category = "测试_道具"
ENT.Author = "Osmos"


function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"price")
	self:NetworkVar("Entity",0,"owning_ent")
end