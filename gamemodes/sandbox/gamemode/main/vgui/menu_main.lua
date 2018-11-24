AddCSLuaFile()

local Genderplane = {
    Init = function( self )
        self:SetSize( ScrW(), 300)
        self:Center()

        local label = vgui.Create( "DLabel", self )
        label:SetSize( 200, 200 )
        label:SetPos( ScrW() / 2 - 100, -60 )
        label:SetText( "请选择一个性别" )
        label:SetFont( "DermaLarge" )

        local buttonplane = vgui.Create( "DPanel", self )
        buttonplane:SetSize( 500, 127 )
        buttonplane:SetPos( ScrW() / 2 - 255, 90 )
        buttonplane.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color( 10, 10, 10, 0 ) )
        end
        
        local imgbutton1 = vgui.Create( "DButton", buttonplane )
        imgbutton1:SetSize( 127, 127 )
        imgbutton1:SetPos( 300, 300)
        imgbutton1:SetText( "" )
        imgbutton1:Dock( LEFT )

        function imgbutton1:Paint( self, w, h )
            --如果按钮被按下
            if( imgbutton1:IsDown() ) then

                --如果按钮有鼠标停留
                elseif( imgbutton1:IsHovered() ) then
                    
                    surface.SetDrawColor( 255, 255, 255, 255 )      --底圈颜色
                    draw.NoTexture()
                    draw.Circle( 65, 65, 45, 45 )
            
                    surface.SetDrawColor( 80, 200, 239, 255 )      --内外圈颜色
                    draw.NoTexture()
                    draw.Circle( 55, 75, 22, 22 )
            
                    surface.SetDrawColor( 255, 255, 255, 255 )      --内圈颜色
                    draw.NoTexture()
                    draw.Circle( 55, 75, 15, 12 )
            
                    local triangle = {
                        { x = 67, y = 60 },
                        { x = 90, y = 39 },
                        { x = 95, y = 45 },
                        { x = 72, y = 68 },
                    }
            
                    surface.SetDrawColor( 80, 200, 239, 255 )      --斜直线颜色
                    draw.NoTexture()
                    surface.DrawPoly( triangle )


                    draw.RoundedBoxEx( 0, 69, 39, 25, 10, Color( 80, 200, 239, 255 ) ) --箭头矩形颜色
                    draw.RoundedBoxEx( 0, 85, 39, 10, 25, Color( 80, 200, 239, 255 ) ) --箭头矩形颜色

                else

                    surface.SetDrawColor( 80, 200, 239, 200 )
                    draw.NoTexture()
                    draw.Circle( 65, 65, 45, 45 )
            
                    surface.SetDrawColor( 255, 255, 255, 255 )
                    draw.NoTexture()
                    draw.Circle( 55, 75, 22, 22 )
            
                    surface.SetDrawColor( 80, 200, 239, 200 )
                    draw.NoTexture()
                    draw.Circle( 55, 75, 15, 12 )
            
                    local triangle = {
                        { x = 67, y = 60 },
                        { x = 90, y = 39 },
                        { x = 95, y = 45 },
                        { x = 72, y = 68 },
                    }
            
                    surface.SetDrawColor( 255, 255, 255, 255 )
                    draw.NoTexture()
                    surface.DrawPoly( triangle )


                    draw.RoundedBoxEx( 0, 69, 39, 25, 10, Color( 255, 255, 255, 255 ) )
                    draw.RoundedBoxEx( 0, 85, 39, 10, 25, Color( 255, 255, 255, 255 ) )

            end

        end

        imgbutton1.DoClick = function()
            net.Start( "Buttonflow" )
                net.WriteString( "malebutton" )
            net.SendToServer()
        end

        local imgbutton2 = vgui.Create( "DButton", buttonplane )
        imgbutton2:SetSize( 127, 127 )
        imgbutton2:SetPos( 300, 300)
        imgbutton2:SetText( "" )
        imgbutton2:Dock( RIGHT  )

        function imgbutton2:Paint( self, w, h )
            --如果按钮被按下
            if( imgbutton2:IsDown() ) then

                --如果按钮有鼠标停留
                elseif( imgbutton2:IsHovered() ) then
            
                    surface.SetDrawColor( 255, 255, 255, 255 )        --底圈颜色
                    draw.NoTexture()
                    draw.Circle( 65, 65, 45, 45 )
            
                    surface.SetDrawColor( 240, 82, 40, 255 )      --内外圈颜色
                    draw.NoTexture()
                    draw.Circle( 65, 52, 22, 22 )
            
                    surface.SetDrawColor( 255, 255, 255, 255 )        --内圈颜色
                    draw.NoTexture()
                    draw.Circle( 65, 52, 15, 12 )
            
                    draw.RoundedBoxEx( 0, 60, 66, 10, 39, Color( 240, 82, 40, 255 ) )     --矩形颜色
                    draw.RoundedBoxEx( 0, 51, 83, 28, 10, Color( 240, 82, 40, 255 ) )     --矩形颜色



                else

                    surface.SetDrawColor( 240, 82, 40, 200 )        
                    draw.NoTexture()
                    draw.Circle( 65, 65, 45, 45 )
            
                    surface.SetDrawColor( 255, 255, 255, 255 )
                    draw.NoTexture()
                    draw.Circle( 65, 52, 22, 22 )
            
                    surface.SetDrawColor( 240, 82, 40, 200 )
                    draw.NoTexture()
                    draw.Circle( 65, 52, 15, 12 )
            
                    draw.RoundedBoxEx( 0, 60, 66, 10, 39, Color( 255, 255, 255, 255 ) )
                    draw.RoundedBoxEx( 0, 51, 83, 28, 10, Color( 255, 255, 255, 255 ) )

            end
        end
        imgbutton2.DoClick = function()
            net.Start( "Buttonflow" )
                net.WriteString( "famalebutton" )
            net.SendToServer()
        end



    end,

    Paint = function ( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 68, 68, 68, 255 ) )
        
    end
}
vgui.Register( "Genderplane", Genderplane )

local f1PANEL = {
    Init = function( self )

        self:SetSize( 960, 670 )
        self:Center()
        self:SetVisible( true )
        --self:MakePopup()
        local x, y = self:GetSize()
        --画按钮
        local button = vgui.Create( "DButton", self )
        button:SetText( "X" )
        button:SetFont( "DermaLarge" )
        button:SetSize( 50, 35 )
        button:SetPos( x - 50, 0 )
        
        --按钮改皮肤
        function button:Paint( w, h )
            --如果按钮被按下
            if( button:IsDown() ) then
                    button:SetColor( Color( 255, 255, 255 ) )
                    draw.RoundedBox( 0, 0, 0, w, h, Color( 215, 90, 74 ) )
                --如果按钮有鼠标停留
                elseif( button:IsHovered() ) then
                    button:SetColor( Color( 255, 255, 255 ) )
                    draw.RoundedBox( 0, 0, 0, w, h, Color( 215, 90, 74 ) )
                else
                    button:SetColor( Color( 0, 0, 0 ) )
                    draw.RoundedBox( 0, 0, 0, w, h, Color( 240, 82, 40 ) )
            end

        end
        --按钮点击事件
        button.DoClick = function()
            self:SetVisible( false )
            gui.EnableScreenClicker( false )
        end
        --标签
        local Label = vgui.Create( "DLabel", self )
        Label:SetFont( "DermaLarge" )
        Label:SetPos( 3, 0 )
        Label:SetText( "帮助菜单" )
        Label:SetColor( Color( 255, 255, 255 ) )
        Label:SizeToContents()

        --选择页按钮背景
        local mainpanel = vgui.Create( "DPanel", self )
        mainpanel:SetPos( 3, 35 )
        mainpanel:SetSize( x - 10, y - 35 -8 ) --y减顶35，减底8
        mainpanel.Paint = function( self, w, h )
            draw.RoundedBox( 0, 4, 0, w, h, Color( 108, 110, 114 ) )
        end
        --选择页按钮
        local colsheet = vgui.Create( "ColumnSheet", mainpanel )
        colsheet:Dock( FILL )


        --创建选择页1
        local sheet1 = vgui.Create( "DPanel", colsheet )
        sheet1:Dock( FILL )
        sheet1.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
        end
        --创建选择夹1按钮
        colsheet:AddSheet( "该怎么玩", sheet1 )
        
        local Text = vgui.Create( "DLabel", sheet1 )
        Text:Dock( TOP )
        Text:SetSize( 800, 30 ) --y减顶35，减底8
        Text:SetText( "简单玩法说明：" )
        Text:SetFont( "DermaLarge" )

        local Text = vgui.Create( "DLabel", sheet1 )
        Text:SetPos( 0, 40 )
        Text:SetSize( 800, 100 )
        Text:SetText( "先到公民npc里转职成公民职业不然什么都做不成哦~.\n基本玩法是生存创造,创作,pvp,等\n" )
        Text:SetFont( "Trebuchet24" )

        local Text = vgui.Create( "DLabel", sheet1 )
        Text:SetPos( 0, 130 )
        Text:SetSize( 800, 30 ) --y减顶35，减底8
        Text:SetText( "职业说明：" )
        Text:SetFont( "DermaLarge" )

        local Text = vgui.Create( "DLabel", sheet1 )
        Text:SetPos( 0, 170 )
        Text:SetSize( 800, 100 )
        Text:SetText( "职业暂有四个\n小职业也暂有四个\n拿到小职业武器自动成为该小职业,职业需要到各npc处就职" )
        Text:SetFont( "Trebuchet24" )

        local Text = vgui.Create( "DLabel", sheet1 )
        Text:SetPos( 0, 300 )
        Text:SetSize( 800, 30 ) --y减顶35，减底8
        Text:SetText( "服务器规则：" )
        Text:SetFont( "DermaLarge" )

        local Text = vgui.Create( "DLabel", sheet1 )
        Text:SetPos( 0, 350 )
        Text:SetSize( 800, 100 )
        Text:SetText( "不能用物理枪抓住物品撞玩家\n不能用物品卡住/罩玩家\n不能無意义/恶意刷物品卡服\n不要的物品记得按Z撤销哦" )
        Text:SetFont( "Trebuchet24" )
        --创建选择页2
        local sheet2 = vgui.Create( "DPanel", colsheet )
        sheet2:Dock( FILL )
        sheet2.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
        end
        --创建选择夹2按钮
        colsheet:AddSheet( "命令列表", sheet2 )

        local Text = vgui.Create( "DLabel", sheet2 )
        Text:Dock( TOP )
        Text:SetSize( 800, 30 ) --y减顶35，减底8
        Text:SetText( "个人信息命令：" )
        Text:SetFont( "DermaLarge" )

        local Text = vgui.Create( "DLabel", sheet2 )
        Text:SetPos( 0, 40 )
        Text:SetSize( 800, 100 )
        Text:SetText( "(聊天框中) !givemoney $ [给准星处的玩家多少$]\n(聊天框中) !check [检查自己身上余额]\n(聊天框中) !dropweapon [丢掉自己手上武器]" )
        Text:SetFont( "Trebuchet24" )
        --内容

        --创建选择页3
        local sheet3 = vgui.Create( "DPanel", colsheet )
        sheet3:Dock( FILL )
        sheet3.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
        end
        --创建选择夹3按钮
        colsheet:AddSheet( "官网", sheet3 )

        --html页
        local html = vgui.Create( "HTML", sheet3 )
        html:Dock( FILL )
        html:OpenURL( "http://nxmod.5a1.xyz/doku.php")
    end,

    Paint = function( self, w, h )

        --底面
        draw.RoundedBox( 0, 4, 3, w - 8, h - 8, Color( 10, 10, 10, 150 ) )
        --描边
        surface.SetDrawColor( 0, 0, 0, 200 )
        surface.DrawOutlinedRect( 4, 3, w - 8, h - 8 )
        --标题背景
        draw.RoundedBox( 0, 0, 0, w , h - 635, Color( 41, 128, 185 ) )
        
    end

}
vgui.Register( "menu_f1main", f1PANEL )
local f4PANEL = {
    Init = function( self )

        --self:MakePopup()
        self:SetSize( 960, 670 )
        self:Center()
        self:SetVisible( true )

        local x, y = self:GetSize()

        local button = vgui.Create( "DButton", self )
        button:SetText( "X" )
        button:SetFont( "DermaLarge" )
        button:SetSize( 50, 35 )
        button:SetPos( x - 50, 0 )

        function button:Paint( w, h )
            
            if( button:IsDown() ) then
                    button:SetColor( Color( 255, 255, 255 ) )
                    draw.RoundedBox( 0, 0, 0, w, h, Color( 215, 90, 74 ) )
                elseif( button:IsHovered() ) then
                    button:SetColor( Color( 255, 255, 255 ) )
                    draw.RoundedBox( 0, 0, 0, w, h, Color( 215, 90, 74 ) )
                else
                    button:SetColor( Color( 0, 0, 0 ) )
                    draw.RoundedBox( 0, 0, 0, w, h, Color( 240, 82, 40 ) )
            end

        end

        button.DoClick = function()
            self:SetVisible( false )
            gui.EnableScreenClicker( false )
        end
        local Label = vgui.Create( "DLabel", self )
        Label:SetFont( "DermaLarge" )
        Label:SetPos( 3, 0 )
        Label:SetText( "主菜单" )
        Label:SetColor( Color( 255, 255, 255 ) )
        Label:SizeToContents()

        --选择页按钮背景
        local mainpanel = vgui.Create( "DPanel", self )
        mainpanel:SetPos( 3, 35 )
        mainpanel:SetSize( x - 10, y - 35 -8)
        mainpanel.Paint = function( self, w, h )
            draw.RoundedBox( 0, 4, 0, w, h, Color( 108, 110, 114 ) )
        end
        --选择页按钮
        local colsheet = vgui.Create( "ColumnSheet", mainpanel )
        colsheet:Dock( FILL )
        --创建选择页1
        local sheet1 = vgui.Create( "DPanel", colsheet )
        sheet1:SetSize( 960, 670 )
        sheet1.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
        end
        --创建选择夹1按钮

        local joblist = vgui.Create( "joblist", sheet1 )
        joblist:Dock( FILL )

        colsheet:AddSheet( "职业列表", sheet1 )

        --创建选择页2
        local sheet2 = vgui.Create( "DPanel", colsheet )
        sheet2:Dock( FILL )
        sheet2.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
        end

        colsheet:AddSheet( "小职业", sheet2 )

    end,

    Paint = function( self, w, h )

        --底面
        draw.RoundedBox( 0, 4, 3, w - 8, h - 8, Color( 10, 10, 10, 150 ) )
        --描边
        surface.SetDrawColor( 0, 0, 0, 200 )
        surface.DrawOutlinedRect( 4, 3, w - 8, h - 8 )
        --标题背景
        draw.RoundedBox( 0, 0, 0, w , h - 635, Color( 41, 128, 185 ) )
        
    end,
}
vgui.Register( "menu_f4main", f4PANEL )


--画生成按钮面板
local PANEL = {}

function PANEL:Init()
    self:Dock( FILL )
	--self:EnableHorizontal(true)
	--self:EnableVerticalScrollbar(true)

    local tbl = {}

    for k, v in pairs( ULib.ucl.groups ) do
        if k ~= "superadmin" and k ~= "admin" and k ~= "operator" and k ~= "user" then
        tbl[k] = {
            team = v.team
        }
        end
    end
    --PrintTable(tbl)
	-- 添加按钮
    for jobgroup, data in pairs(tbl) do
        if !data.team then continue end
        local joblist = vgui.Create( "jobpanel", self )
        local models = player_manager.AllValidModels() 
        joblist:SetSize( 265, 209 )
        if !models[data.team.femalemodel] and !models[data.team.femalemodel] then return end
        joblist:jobdata( jobgroup, models[data.team.femalemodel], models[data.team.malemodel], data.team.description, data.team.mcost, data.team.lcost )

        self:Add( joblist )
    end
end
vgui.Register("joblist", PANEL,"DIconLayout")

--画生成按钮面板
local PANEL = {}

function PANEL:Init()
    self.panel = vgui.Create( "DPanel", self )
    self.panel:SetPos( 5, 5 )
    self.panel:SetSize( 265, 209 )
    self.panel.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w - 5, h - 1, Color( 0, 100, 150 ) )
    end
    
    self.bgd = vgui.Create( "DPanel", self.panel )
    self.bgd:SetPos( 5, 5 )
    self.bgd:SetSize( 133, 73 )
    self.bgd.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w - 10, h - 10, Color( 0, 0, 0 ) )
    end
    self.frame1 = vgui.Create( "DPanel", self.bgd )
    self.frame1:SetPos( 3, 3 )
    self.frame1:SetSize( 60, 60 )
    self.frame1.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w - 3, h - 3, Color( 255, 255, 255 ) )
    end
    self.frame2 = vgui.Create( "DPanel", self.bgd )
    self.frame2:SetPos( 63, 3 )
    self.frame2:SetSize( 60, 60 )
    self.frame2.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w - 3, h - 3, Color( 255, 255, 255 ) )
    end
    self.jobmodel1 = vgui.Create( "DModelPanel", self.bgd )
    self.jobmodel1:SetSize( 60, 60 )
    function self.jobmodel1:LayoutEntity( Entity ) return end
    local angl1 = 60
    self.jobmodel1:SetCamPos( Vector(40,-15,angl1) )
    self.jobmodel1:SetLookAt( Vector(0,0,(angl1 + 3) ) )
    self.jobmodel1:SetFOV( 20 )	

    self.jobmodel2 = vgui.Create( "DModelPanel", self.bgd )
    self.jobmodel2:SetSize( 60, 60 )
    self.jobmodel2:SetPos( 60, 0 )
    function self.jobmodel2:LayoutEntity( Entity ) return end
    local angl2 = 60
    self.jobmodel2:SetCamPos( Vector(53,-15,angl2) )
    self.jobmodel2:SetLookAt( Vector(0,0,(angl2 + 3) ) )
    self.jobmodel2:SetFOV( 20 )	

    self.jobname = vgui.Create( "DLabel", self.panel )
    self.jobname:SetPos( 175, 0 )
    self.jobname:SetSize( 80, 30 )
    self.jobname:SetFont( "Trebuchet18" )
    --self.jobname:SetColor( Color( 255, 255, 255 ) )

    self.jobbutton = vgui.Create( "DButton", self.panel )
    self.jobbutton:SetPos( 173, 168 )
    self.jobbutton:SetSize( 83, 31 )
    self.jobbutton:SetText( "就职" )
    self.jobbutton:SetFont( "Trebuchet24" )
    --按钮改皮肤
    function self.jobbutton:Paint( w, h )
        --如果按钮被按下
        if( self:IsDown() ) then
            self:SetColor( Color( 255, 255, 255 ) )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 165, 215, 110 ) )
        --如果按钮有鼠标停留
        elseif( self:IsHovered() ) then
            self:SetColor( Color( 255, 255, 255 ) )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 165, 215, 110 ) )
        else
            self:SetColor( Color( 0, 0, 0 ) )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 195, 230, 120 ) )
        end

    end
    self.rejobbutton = vgui.Create( "DButton", self.panel )
    self.rejobbutton:SetPos( 173, 168 )
    self.rejobbutton:SetSize( 83, 31 )
    self.rejobbutton:SetText( "离职" )
    self.rejobbutton:SetFont( "Trebuchet24" )
    self.rejobbutton:SetVisible( false )
    --按钮改皮肤
    function self.rejobbutton:Paint( w, h )
        --如果按钮被按下
        if( self:IsDown() ) then
            self:SetColor( Color( 255, 255, 255 ) )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 215, 90, 74 ) )
        --如果按钮有鼠标停留
        elseif( self:IsHovered() ) then
            self:SetColor( Color( 255, 255, 255 ) )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 215, 90, 74 ) )
        else
            self:SetColor( Color( 0, 0, 0 ) )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 240, 82, 40 ) )
        end

    end

    self.jobmcost = vgui.Create( "DLabel", self.panel )
    self.jobmcost:SetPos( 155, 20 )
    self.jobmcost:SetSize( 80, 30 )
    self.jobmcost:SetFont( "Trebuchet18" )
    --self.jobmcost:SetColor( Color( 255, 255, 255 ) )

    self.joblcost = vgui.Create( "DLabel", self.panel )
    self.joblcost:SetPos( 155, 40 )
    self.joblcost:SetSize( 80, 30 )
    self.joblcost:SetFont( "Trebuchet18" )
    --self.joblcost:SetColor( Color( 255, 255, 255 ) )

    self.jobinfo = vgui.Create( "DLabel", self.panel )
    self.jobinfo:SetPos( 0, 60 )
    self.jobinfo:SetSize( 255, 90 )
    self.jobinfo:SetFont( "Trebuchet18" )
    self.jobinfo:SetWrap( true )
    --self.jobinfo:SetColor( Color( 255, 255, 255 ) )

end

function PANEL:jobdata( jobname, femalemodel, malemodel, info, mcost, lcost )
    
    self.jobmodel1:SetModel( femalemodel )
    self.jobmodel2:SetModel( malemodel )

    local name
    if jobname == "citizen" then
        name = "公民"
    elseif jobname == "doctor" then
        name = "医生"
    elseif jobname == "poilce" then
        name = "警察"
    elseif jobname == "project" then
        name = "工程"
    end
    self.jobname:SetText( name )
    self.jobmcost:SetText( "就职: -" .. tostring(mcost) .. "$" )
    self.joblcost:SetText( "离职: +" .. tostring(lcost) .. "$" )
    self.jobinfo:SetText( info )

    timer.Simple( 0, function()
        if LocalPlayer():GetUserGroup() == jobname then
            self.jobbutton:SetVisible( false )
            self.rejobbutton:SetVisible( true )
        else
            self.jobbutton:SetVisible( true )
            self.rejobbutton:SetVisible( false )
        end
        if jobname == "citizen" then
            self.jobbutton:SetVisible( false )
            self.rejobbutton:SetVisible( false )
        end
    end)

    --就职按钮点击事件
    self.jobbutton.DoClick = function()
        if LocalPlayer():GetUserGroup() == "citizen" then
            net.Start( "Buttonflow" )
                net.WriteString( "cagjob" )
                net.WriteString( jobname )
                net.WriteFloat( mcost )
            net.SendToServer()
            self.jobbutton:SetVisible( false )
            self.rejobbutton:SetVisible( true )
        elseif LocalPlayer():GetUserGroup() == "user" then
            notification.AddLegacy( "你需要到npc处成为公民才能转职", NOTIFY_GENERIC, 5 ) 
            surface.PlaySound( "buttons/lever8.wav" )
        else
            notification.AddLegacy( "你需要辞掉 现在的 职业才能转职", NOTIFY_GENERIC, 5 ) 
            surface.PlaySound( "buttons/lever8.wav" )
        end
    end
    --离职按钮点击事件
    self.rejobbutton.DoClick = function()
        if LocalPlayer():GetUserGroup() == "citizen" then
            notification.AddLegacy( "你需要npc处才能辞掉 " .. name .. " 职业", NOTIFY_GENERIC, 5 ) 
        else
            net.Start( "Buttonflow" )
                net.WriteString( "rejob" )
                net.WriteString( "" )
                net.WriteFloat( lcost )
            net.SendToServer()
            self.jobbutton:SetVisible( true )
            self.rejobbutton:SetVisible( false )
        end
    end

end
vgui.Register( "jobpanel", PANEL )