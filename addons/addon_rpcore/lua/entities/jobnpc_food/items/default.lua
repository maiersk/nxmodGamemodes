if SERVER then
    --物品受到伤害自爆
    timer.Create( "CollideDamagecheck", 1, 0, function() 
        for _, v in pairs( ents.GetAll() ) do
            for key, data in pairs( items.food ) do
                if v:GetClass() == data.class then
                    if !v.damage then return end
                    --print(v.damage)
                    if v.damage <= 0 then
                        v:Destruct()
                        v:Remove()
                    end
                end
            end
        end
    end) 
end

items.AddFoodTable{
    name = "饮料",
    class = "food_mod_drinks",
    models = {"models/mechanics/various/211.mdl"},
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
		self:SetModel("models/mechanics/various/211.mdl")
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
        if self.inbox then return end
        if ( IsValid( self ) && LocalPlayer():GetPos():Distance( self:GetPos() ) < 500 ) then

            local ang = Angle( 0, ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "yaw" ], ( LocalPlayer():GetPos() - self:GetPos() ):Angle()[ "pitch" ] ) + Angle( 0, 90, 60 )
            local ang2 = self:GetAngles()
            --按指定的度数旋转指定轴周围的角度。
            ang2:RotateAroundAxis(ang2:Up(), 90 );   --保持上下旋转都在这个面
            ang2:RotateAroundAxis(ang2:Forward(), 360 );    --保持前后旋转都在这个面
            for _, v in pairs(items.food) do
                cam.IgnoreZ( false )
                cam.Start3D2D( self:GetPos() + ang2:Up() *15 , ang, .2 )
                    draw.SimpleTextOutlined( v.price .. "$", "Trebuchet18", -2, 0, Color(150, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, Color(0, 0, 0, 255))
                cam.End3D2D()
            end
        end
        
    end

end

scripted_ents.Register(ENT, "food_mod_drinks", true)
---------------------------------------------------------------------------
items.AddFoodTable{
    name = "西瓜",
    class = "food_mod_watermelon",
    models = {"models/foodnhouseholditems/watermelon_unbreakable.mdl"},
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
		self:SetModel("models/foodnhouseholditems/watermelon_unbreakable.mdl")
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
                cam.Start3D2D( self:GetPos() + ang2:Up() *15 , ang, .2 )
                    draw.SimpleTextOutlined( v.price .. "$", "Trebuchet18", -2, 0, Color(150, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, Color(0, 0, 0, 255))
                cam.End3D2D()
            end
        end
        
    end

end

scripted_ents.Register(ENT, "food_mod_watermelon", true)
---------------------------------------------------------------------------
items.AddFoodTable{
    name = "牛奶",
    class = "food_mod_milkcarton",
    models = {"models/props_junk/garbage_milkcarton002a.mdl"},
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
		self:SetModel("models/props_junk/garbage_milkcarton002a.mdl")
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
                cam.Start3D2D( self:GetPos() + ang2:Up() *15 , ang, .2 )
                    draw.SimpleTextOutlined( v.price .. "$", "Trebuchet18", -2, 0, Color(150, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, Color(0, 0, 0, 255))
                cam.End3D2D()
            end
        end
        
    end

end

scripted_ents.Register(ENT, "food_mod_milkcarton", true)
---------------------------------------------------------------------------
items.AddFoodTable{
    name = "烧酒",
    class = "food_mod_glassbottle",
    models = {"models/props_junk/garbage_glassbottle001a.mdl"},
    cost = 50,
    price = 100, 
    textinfo = [[
        高度烧酒，注意！醉了会不受控制乱动。
    ]],

}
local ENT = {}

ENT.Type = "anim"
ENT.Base = "food_mod_base"

if SERVER then 
    function ENT:Initialize()
		self:SetModel("models/props_junk/garbage_glassbottle001a.mdl")
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
            self:EmitSound("npc/barnacle/barnacle_gulp2.wav")

            cmds = {"left", "right", "moveleft", "moveright", "forward", "back", "attack", "walk", "speed", "jump", "zoom", "duck", "use"}
            
            rancmds = {table.Random(cmds), table.Random(cmds),table.Random(cmds),table.Random(cmds),table.Random(cmds),table.Random(cmds),table.Random(cmds),table.Random(cmds),table.Random(cmds),table.Random(cmds),}
            
            caller:SetNWInt("drinks", caller:GetNWInt("drinks") + 1)
            
            for i=1, 10 do
                timer.Simple(5 * i, function()
                    if math.random(1,25) == 1 then
                        if !caller:Alive() then return end
                        caller:EmitSound("npc/zombie/zombie_pain" .. math.random(1,3) .. ".wav")
                    end
                    if !caller:Alive() then return end
                    if caller:GetNWInt("drinks") == 0 then return end
                    caller:ConCommand("+" .. rancmds[i])
                    timer.Simple(math.random(1,3), function()
                        caller:ConCommand("-" .. rancmds[i])
                    end)
                end)
            end
            timer.Simple(50, function()
                for i=1, 13 do
                    if !caller:Alive() then return end
                    caller:ConCommand("-" .. cmds[i])
                    caller:SetNWInt("drinks", caller:GetNWInt("drinks") - 1)
                end
            end)
            
            local hunger = caller:GetNWFloat("hunger")
            local value = 8
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
                cam.Start3D2D( self:GetPos() + ang2:Up() *15 , ang, .2 )
                    draw.SimpleTextOutlined( v.price .. "$", "Trebuchet18", -2, 0, Color(150, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, Color(0, 0, 0, 255))
                cam.End3D2D()
            end
        end
        
    end

end

scripted_ents.Register(ENT, "food_mod_glassbottle", true)
---------------------------------------------------------------------------
items.AddFoodTable{
    name = "鸡蛋",
    class = "food_mod_egg",
    models = {"models/props_phx/misc/egg.mdl"},
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
		self:SetModel("models/props_phx/misc/egg.mdl")
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
                cam.Start3D2D( self:GetPos() + ang2:Up() *10 , ang, .2 )
                    draw.SimpleTextOutlined( v.price .. "$", "Trebuchet18", -2, 0, Color(150, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, Color(0, 0, 0, 255))
                cam.End3D2D()
            end
        end
        
    end

end

scripted_ents.Register(ENT, "food_mod_egg", true)
---------------------------------------------------------------------------
items.AddFoodTable{
    name = "甜甜圈",
    class = "food_mod_donut",
    models = {"models/noesis/donut.mdl"},
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
		self:SetModel("models/noesis/donut.mdl")
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
                cam.Start3D2D( self:GetPos() + ang2:Up() *15 , ang, .2 )
                    draw.SimpleTextOutlined( v.price .. "$", "Trebuchet18", -2, 0, Color(150, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, Color(0, 0, 0, 255))
                cam.End3D2D()
            end
        end
        
    end

end

scripted_ents.Register(ENT, "food_mod_donut", true)
---------------------------------------------------------------------------
items.AddFoodTable{
    name = "汉堡",
    class = "food_mod_burger",
    models = {"models/food/burger.mdl"},
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
		self:SetModel("models/food/burger.mdl")
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
                cam.Start3D2D( self:GetPos() + ang2:Up() *25 , ang, .2 )
                    draw.SimpleTextOutlined( v.price .. "$", "Trebuchet18", -2, 0, Color(150, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, Color(0, 0, 0, 255))
                cam.End3D2D()
            end
        end
        
    end

end

scripted_ents.Register(ENT, "food_mod_burger", true)
---------------------------------------------------------------------------
items.AddFoodTable{
    name = "热狗",
    class = "food_mod_hotdog",
    models = {"models/food/hotdog.mdl"},
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
		self:SetModel("models/food/hotdog.mdl")
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
                cam.Start3D2D( self:GetPos() + ang2:Up() *25 , ang, .2 )
                    draw.SimpleTextOutlined( v.price .. "$", "Trebuchet18", -2, 0, Color(150, 255, 255, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, .5, Color(0, 0, 0, 255))
                cam.End3D2D()
            end
        end
        
    end

end

scripted_ents.Register(ENT, "food_mod_hotdog", true)