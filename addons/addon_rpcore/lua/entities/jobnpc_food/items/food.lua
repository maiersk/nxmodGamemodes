items.AddFoodTable{
    name = "派",
    class = "food_mod_pie",
    models = {"models/foodnhouseholditems/pie.mdl"},
    cost = 50,
    price = 100, 
    textinfo = [[

    ]],

}
local ENT = {}

ENT.Type = "anim"
ENT.Base = "food_mod_base"

if SERVER then 
    function ENT:Initialize()
		self:SetModel("models/foodnhouseholditems/pie.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self.damage = self:EntIndex()
        self.inbox = false
        self.Ding = true
	end
    
    function ENT:Use(activator, caller)
        --print(self.inbox)
        --print(self.Ding)
        if caller ~= player.GetByUniqueID(self.data.ownerid) then
            caller:SendLua("notification.AddLegacy( \"这食物你还没购买呢,不能吃哦!按R购买\", NOTIFY_GENERIC, 2.5 )")
            return 
        end
        if !self.inbox and self.Ding then           --初始生成不在箱中能固定到箱子里,按E吃掉 /第二次取消固定还原值可以吃
            self:EatEnt(caller)
        elseif self.inbox and self.Ding then        --第一次固定箱中可吃
            self:EatEnt(caller)
        elseif !self.inbox and !self.Ding then      --在箱中固定过取消固定了也能吃
            self:EatEnt(caller)
        end

    end

    function ENT:PhysicsCollide(data, physobj)
        --print(physobj:GetEntity())
        local dmg = DamageInfo()
		dmg:SetDamage( 1 )
        self:TakePhysicsDamage(dmg)
		self.damage = self.damage - dmg:GetDamage()
    end

    function ENT:EndTouch(hitEnt)
        for _, v in pairs(items.food) do 
            if v.isbox then
                self.inbox = false              --结束碰撞则不在箱中
            end
        end
    end

    function ENT:EatEnt(caller)
        if IsValid(caller) and caller:IsPlayer() then
            local hunger = caller:GetNWFloat("hunger")
            local value = 28
            if (hunger >= 100-value) then
                caller:SetNWFloat("hunger",100)
            else
                hunger = hunger + value
                caller:SetNWFloat("hunger",hunger)
            end
            self:Remove()
        end
    end
    
    function ENT:OnTakeDamage(dmg)
        self:TakePhysicsDamage(dmg)
		self.damage = self.damage - dmg:GetDamage()
		if self.damage <= 0 then
			self:Destruct()
			self:Remove()
		end
    end

    function ENT:Destruct() --自毁特效
		local vPoint = self:GetPos()
		local effectdata = EffectData()
		effectdata:SetStart(vPoint)
		effectdata:SetOrigin(vPoint)
		effectdata:SetScale(1)
		util.Effect("Explosion", effectdata)
    end
    
end

if CLIENT then

    function ENT:Draw()

        self:DrawModel()
        
        if ( IsValid( self ) && LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 ) then

            local ang = Angle( 0, ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "yaw" ], ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "pitch" ] ) + Angle( 0, 90, 60 )
            local ang2 = self:GetAngles()
            --按指定的度数旋转指定轴周围的角度。
            ang2:RotateAroundAxis(ang2:Up(), 90 );   --保持上下旋转都在这个面
            ang2:RotateAroundAxis(ang2:Forward(), 360 );    --保持前后旋转都在这个面
            for _, v in pairs(items.food) do
                cam.IgnoreZ( false )
                cam.Start3D2D( self:GetPos() + ang2:Up() *2 , ang, .2 )
                    draw.SimpleTextOutlined( v.price .. "$", "Trebuchet18", -2, 0, Color(150, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, Color(0, 0, 0, 255))
                cam.End3D2D()
            end
        end
        
    end

end

scripted_ents.Register(ENT, "food_mod_pie", true)
---------------------------------------------------------------------------
items.AddFoodTable{
    name = "长方面包",
    class = "food_mod_bread",
    models = {"models/foodnhouseholditems/bread-3.mdl"},
    cost = 50,
    price = 100, 
    textinfo = [[

    ]],

}
local ENT = {}

ENT.Type = "anim"
ENT.Base = "food_mod_base"

if SERVER then 
    function ENT:Initialize()
		self:SetModel("models/foodnhouseholditems/bread-3.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self.damage = self:EntIndex()
        self.inbox = false
        self.Ding = true
	end
    
    function ENT:Use(activator, caller)
        --print(self.inbox)
        --print(self.Ding)
        if caller ~= player.GetByUniqueID(self.data.ownerid) then
            caller:SendLua("notification.AddLegacy( \"这食物你还没购买呢,不能吃哦!按R购买\", NOTIFY_GENERIC, 2.5 )")
            return 
        end
        if !self.inbox and self.Ding then           --初始生成不在箱中能固定到箱子里,按E吃掉 /第二次取消固定还原值可以吃
            self:EatEnt(caller)
        elseif self.inbox and self.Ding then        --第一次固定箱中可吃
            self:EatEnt(caller)
        elseif !self.inbox and !self.Ding then      --在箱中固定过取消固定了也能吃
            self:EatEnt(caller)
        end

    end

    function ENT:PhysicsCollide(data, physobj)
        --print(physobj:GetEntity())
        local dmg = DamageInfo()
		dmg:SetDamage( 1 )
        self:TakePhysicsDamage(dmg)
		self.damage = self.damage - dmg:GetDamage()
    end

    function ENT:EndTouch(hitEnt)
        for _, v in pairs(items.food) do 
            if v.isbox then
                self.inbox = false              --结束碰撞则不在箱中
            end
        end
    end

    function ENT:EatEnt(caller)
        if IsValid(caller) and caller:IsPlayer() then
            local hunger = caller:GetNWFloat("hunger")
            local value = 25
            if (hunger >= 100-value) then
                caller:SetNWFloat("hunger",100)
            else
                hunger = hunger + value
                caller:SetNWFloat("hunger",hunger)
            end
            self:Remove()
        end
    end
    
    function ENT:OnTakeDamage(dmg)
        self:TakePhysicsDamage(dmg)
		self.damage = self.damage - dmg:GetDamage()
		if self.damage <= 0 then
			self:Destruct()
			self:Remove()
		end
    end

    function ENT:Destruct() --自毁特效
		local vPoint = self:GetPos()
		local effectdata = EffectData()
		effectdata:SetStart(vPoint)
		effectdata:SetOrigin(vPoint)
		effectdata:SetScale(1)
		util.Effect("Explosion", effectdata)
    end
    
end

if CLIENT then

    function ENT:Draw()

        self:DrawModel()
        
        if ( IsValid( self ) && LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 ) then

            local ang = Angle( 0, ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "yaw" ], ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "pitch" ] ) + Angle( 0, 90, 60 )
            local ang2 = self:GetAngles()
            --按指定的度数旋转指定轴周围的角度。
            ang2:RotateAroundAxis(ang2:Up(), 90 );   --保持上下旋转都在这个面
            ang2:RotateAroundAxis(ang2:Forward(), 360 );    --保持前后旋转都在这个面
            for _, v in pairs(items.food) do
                cam.IgnoreZ( false )
                cam.Start3D2D( self:GetPos() + ang2:Up() *6 , ang, .2 )
                    draw.SimpleTextOutlined( v.price .. "$", "Trebuchet18", -2, 0, Color(150, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, Color(0, 0, 0, 255))
                cam.End3D2D()
            end
        end
        
    end

end

scripted_ents.Register(ENT, "food_mod_bread", true)
---------------------------------------------------------------------------
items.AddFoodTable{
    name = "披萨",
    class = "food_mod_pizza",
    models = {"models/foodnhouseholditems/pizza.mdl"},
    cost = 50,
    price = 100, 
    textinfo = [[

    ]],

}
local ENT = {}

ENT.Type = "anim"
ENT.Base = "food_mod_base"

if SERVER then 
    function ENT:Initialize()
		self:SetModel("models/foodnhouseholditems/pizza.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self.damage = self:EntIndex()
        self.inbox = false
        self.Ding = true
	end
    
    function ENT:Use(activator, caller)
        --print(self.inbox)
        --print(self.Ding)
        if caller ~= player.GetByUniqueID(self.data.ownerid) then
            caller:SendLua("notification.AddLegacy( \"这食物你还没购买呢,不能吃哦!按R购买\", NOTIFY_GENERIC, 2.5 )")
            return 
        end
        if !self.inbox and self.Ding then           --初始生成不在箱中能固定到箱子里,按E吃掉 /第二次取消固定还原值可以吃
            self:EatEnt(caller)
        elseif self.inbox and self.Ding then        --第一次固定箱中可吃
            self:EatEnt(caller)
        elseif !self.inbox and !self.Ding then      --在箱中固定过取消固定了也能吃
            self:EatEnt(caller)
        end

    end

    function ENT:PhysicsCollide(data, physobj)
        --print(physobj:GetEntity())
        local dmg = DamageInfo()
		dmg:SetDamage( 1 )
        self:TakePhysicsDamage(dmg)
		self.damage = self.damage - dmg:GetDamage()
    end

    function ENT:EndTouch(hitEnt)
        for _, v in pairs(items.food) do 
            if v.isbox then
                self.inbox = false              --结束碰撞则不在箱中
            end
        end
    end

    function ENT:EatEnt(caller)
        if IsValid(caller) and caller:IsPlayer() then
            local hunger = caller:GetNWFloat("hunger")
            local value = 25
            if (hunger >= 100-value) then
                caller:SetNWFloat("hunger",100)
            else
                hunger = hunger + value
                caller:SetNWFloat("hunger",hunger)
            end
            self:Remove()
        end
    end
    
    function ENT:OnTakeDamage(dmg)
        self:TakePhysicsDamage(dmg)
		self.damage = self.damage - dmg:GetDamage()
		if self.damage <= 0 then
			self:Destruct()
			self:Remove()
		end
    end

    function ENT:Destruct() --自毁特效
		local vPoint = self:GetPos()
		local effectdata = EffectData()
		effectdata:SetStart(vPoint)
		effectdata:SetOrigin(vPoint)
		effectdata:SetScale(1)
		util.Effect("Explosion", effectdata)
    end
    
end

if CLIENT then

    function ENT:Draw()

        self:DrawModel()
        
        if ( IsValid( self ) && LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 ) then

            local ang = Angle( 0, ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "yaw" ], ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "pitch" ] ) + Angle( 0, 90, 60 )
            local ang2 = self:GetAngles()
            --按指定的度数旋转指定轴周围的角度。
            ang2:RotateAroundAxis(ang2:Up(), 90 );   --保持上下旋转都在这个面
            ang2:RotateAroundAxis(ang2:Forward(), 360 );    --保持前后旋转都在这个面
            for _, v in pairs(items.food) do
                cam.IgnoreZ( false )
                cam.Start3D2D( self:GetPos() + ang2:Up() *2 , ang, .2 )
                    draw.SimpleTextOutlined( v.price .. "$", "Trebuchet18", -2, 0, Color(150, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, Color(0, 0, 0, 255))
                cam.End3D2D()
            end
        end
        
    end

end

scripted_ents.Register(ENT, "food_mod_pizza", true)
---------------------------------------------------------------------------
items.AddFoodTable{
    name = "大块培根",
    class = "food_mod_bacon",
    models = {"models/foodnhouseholditems/bacon_2.mdl"},
    cost = 50,
    price = 100, 
    textinfo = [[

    ]],

}
local ENT = {}

ENT.Type = "anim"
ENT.Base = "food_mod_base"

if SERVER then 
    function ENT:Initialize()
		self:SetModel("models/foodnhouseholditems/bacon_2.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self.damage = self:EntIndex()
        self.inbox = false
        self.Ding = true
	end
    
    function ENT:Use(activator, caller)
        --print(self.inbox)
        --print(self.Ding)
        if caller ~= player.GetByUniqueID(self.data.ownerid) then
            caller:SendLua("notification.AddLegacy( \"这食物你还没购买呢,不能吃哦!按R购买\", NOTIFY_GENERIC, 2.5 )")
            return 
        end
        if !self.inbox and self.Ding then           --初始生成不在箱中能固定到箱子里,按E吃掉 /第二次取消固定还原值可以吃
            self:EatEnt(caller)
        elseif self.inbox and self.Ding then        --第一次固定箱中可吃
            self:EatEnt(caller)
        elseif !self.inbox and !self.Ding then      --在箱中固定过取消固定了也能吃
            self:EatEnt(caller)
        end

    end

    function ENT:PhysicsCollide(data, physobj)
        --print(physobj:GetEntity())
        local dmg = DamageInfo()
		dmg:SetDamage( 1 )
        self:TakePhysicsDamage(dmg)
		self.damage = self.damage - dmg:GetDamage()
    end

    function ENT:EndTouch(hitEnt)
        for _, v in pairs(items.food) do 
            if v.isbox then
                self.inbox = false              --结束碰撞则不在箱中
            end
        end
    end

    function ENT:EatEnt(caller)
        if IsValid(caller) and caller:IsPlayer() then
            local hunger = caller:GetNWFloat("hunger")
            local value = 25
            if (hunger >= 100-value) then
                caller:SetNWFloat("hunger",100)
            else
                hunger = hunger + value
                caller:SetNWFloat("hunger",hunger)
            end
            self:Remove()
        end
    end
    
    function ENT:OnTakeDamage(dmg)
        self:TakePhysicsDamage(dmg)
		self.damage = self.damage - dmg:GetDamage()
		if self.damage <= 0 then
			self:Destruct()
			self:Remove()
		end
    end

    function ENT:Destruct() --自毁特效
		local vPoint = self:GetPos()
		local effectdata = EffectData()
		effectdata:SetStart(vPoint)
		effectdata:SetOrigin(vPoint)
		effectdata:SetScale(1)
		util.Effect("Explosion", effectdata)
    end
    
end

if CLIENT then

    function ENT:Draw()

        self:DrawModel()
        
        if ( IsValid( self ) && LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 ) then

            local ang = Angle( 0, ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "yaw" ], ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "pitch" ] ) + Angle( 0, 90, 60 )
            local ang2 = self:GetAngles()
            --按指定的度数旋转指定轴周围的角度。
            ang2:RotateAroundAxis(ang2:Up(), 90 );   --保持上下旋转都在这个面
            ang2:RotateAroundAxis(ang2:Forward(), 360 );    --保持前后旋转都在这个面
            for _, v in pairs(items.food) do
                cam.IgnoreZ( false )
                cam.Start3D2D( self:GetPos() + ang2:Up() *2 , ang, .2 )
                    draw.SimpleTextOutlined( v.price .. "$", "Trebuchet18", -2, 0, Color(150, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, Color(0, 0, 0, 255))
                cam.End3D2D()
            end
        end
        
    end

end

scripted_ents.Register(ENT, "food_mod_bacon", true)