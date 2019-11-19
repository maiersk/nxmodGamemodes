local delay = 100						--多久减饥饿值/饥饿值延迟
local Meta = FindMetaTable("Player")

--设置饱腹度
function Meta:SHMInit()
	if not IsValid(self) then return end
	self:SetNWFloat( "hunger", 100 )
	self:SetNWFloat( "hungerspeed", 1 + math.random(1, 2) )
end
--当玩家进服时饱腹度
hook.Add("PlayerInitialSpawn", "SHMInitialPlayerSpawn", function(ply) 
	ply:SHMInit()
end)
--当玩家复活时饱腹度
hook.Add("PlayerSpawn", "SHMPlayerSpawn", function(ply)
	ply:SetNWFloat( "hunger", 100 )
	ply:SetNWFloat( "hungerspeed", 1 + math.random(1, 2) )
end)

local function hungerdelay(Meta)
	if Meta:GetNWFloat( "hunger" ) == 100 then
		delay = 150
	elseif Meta:GetNWFloat( "hunger" ) == 0 then
		delay = 5
	elseif Meta:GetNWFloat( "hunger" ) == 30 then
		delay = 50
	end
end
--主要函数
function Meta:HUpdate()
	hungerdelay(self)
	if not IsValid(self) then 
		return 
	end
	--print(self:GetNWFloat("hunger"))
	self:SetNWFloat("hunger", math.Clamp(self:GetNWFloat("hunger") - self:GetNWFloat("hungerspeed"), 0, 100))
	--print(self:GetNWFloat("hunger"))
	if self:GetNWFloat("hunger") == 0 then
		local health = self:Health()
		local dmg = DamageInfo()
		local dmgvalue = 1 + math.random(2, 5)
		dmg:SetDamage( dmgvalue )
		dmg:SetInflictor(self)
		dmg:SetAttacker(self)
		dmg:SetDamageType( DMG_NERVEGAS )

		self:TakeDamageInfo(dmg)
	end
end
--遍历全服玩家,开始按时减饥饿值
function Think()
	for k, v in pairs( player.GetAll() ) do
		if not v:Alive() then continue end
		v:HUpdate()
	end
	timer.Remove( "HungerGeneral" )
	timer.Create( "HungerGeneral", delay, 1, Think )
end
--定时执行
timer.Create( "HungerGeneral", delay, 1, Think )
