include("shared.lua")

surface.CreateFont( "buttontext1", {
	font = "DebugFixedSmall", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 16,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "buttontext2", {
	font = "DebugFixedSmall", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 20,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont("price", {
	font = "ChatFont",
	size = 24,
	weight = 600,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
});

surface.CreateFont("slottext", {
	font = "ChatFont",
	size = 48,
	weight = 600,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
});

local BACKGROUND_COLOR = Color( 25, 25, 25, 200 );
local BORDER_COLOR = Color( 222, 209, 139, 200 );
local TEXT_COLOR = Color(222, 209, 139, 200);
--local UNKNOWN_COLOR = Color(223, 140, 152, 200);
local ACTIVE_COLOR = Color(153, 224, 141, 200);
local BACKGROUND_COLOR = Color(25, 25, 25,  200);
local EMPTY_COLOR = Color(224, 141, 153, 200);


function ENT:Draw()
    self:DrawModel() --绘制实体或模型

    local pos = self:GetPos()                           --将指定的位置和角度从指定的局部坐标系转换为世界空间坐标。
    local ang = self:GetAngles()                        --角度：取当前物品角度 + 显示角度——这样物品移动界面跟着移动

    --设置按钮点
    local slot1Pos = self:GetPos() + self:GetUp() *36.8 + self:GetRight() *-5 + self:GetForward() *36.5
    local slot2Pos = self:GetPos() + self:GetUp() *36.8 + self:GetRight() *-5 + self:GetForward() *-37
    local slot3Pos = self:GetPos() + self:GetUp() *23.3 + self:GetRight() *-9 + self:GetForward() *36.5
    local slot4Pos = self:GetPos() + self:GetUp() *23.3 + self:GetRight() *-9+ self:GetForward() *-37
    local slot5Pos = self:GetPos() + self:GetUp() *14.8 + self:GetRight() *-16 + self:GetForward() *36.5
    local slot6Pos = self:GetPos() + self:GetUp() *14.8 + self:GetRight() *-16 + self:GetForward() *18.6
    local slot7Pos = self:GetPos() + self:GetUp() *14.8 + self:GetRight() *-16 + self:GetForward() *-0.1
    local slot8Pos = self:GetPos() + self:GetUp() *14.8 + self:GetRight() *-16 + self:GetForward() *-18.3
    local slot9Pos = self:GetPos() + self:GetUp() *14.8 + self:GetRight() *-16 + self:GetForward() *-37

    --按钮颜色
    local slot1Color = TEXT_COLOR;
	local slot2Color = TEXT_COLOR;
	local slot3Color = TEXT_COLOR;
	local slot4Color = TEXT_COLOR;
	local slot5Color = TEXT_COLOR;
	local slot6Color = TEXT_COLOR;
	local slot7Color = TEXT_COLOR;
	local slot8Color = TEXT_COLOR;
	local slot9Color = TEXT_COLOR;

	local slot1Text = TEXT_COLOR;
	local slot2Text = TEXT_COLOR;
	local slot3Text = TEXT_COLOR;
	local slot4Text = TEXT_COLOR;
	local slot5Text = TEXT_COLOR;
	local slot1Text = TEXT_COLOR;
	local slot7Text = TEXT_COLOR;
	local slot8Text = TEXT_COLOR;
	local slot9Text = TEXT_COLOR;

	if self:GetNWString("slot1") != "空" then
		slot1Text = TEXT_COLOR;
	else
		slot1Text = EMPTY_COLOR;
	end;

	if self:GetNWString("slot2") != "空" then
		slot2Text = TEXT_COLOR;
	else
		slot2Text = EMPTY_COLOR;
	end;

	if self:GetNWString("slot3") != "空" then
		slot3Text = TEXT_COLOR;
	else
		slot3Text = EMPTY_COLOR;
	end;

	if self:GetNWString("slot4") != "空" then
		slot4Text = TEXT_COLOR;
	else
		slot4Text = EMPTY_COLOR;
	end;
	
	if self:GetNWString("slot5") != "空" then
		slot5Text = TEXT_COLOR;
	else
		slot5Text = EMPTY_COLOR;
	end;
	
	if self:GetNWString("slot6") != "空" then
		slot6Text = TEXT_COLOR;
	else
		slot6Text = EMPTY_COLOR;
	end;		

	if self:GetNWString("slot7") != "空" then
		slot7Text = TEXT_COLOR;
	else
		slot7Text = EMPTY_COLOR;
	end;

	if self:GetNWString("slot8") != "空" then
		slot8Text = TEXT_COLOR;
	else
		slot8Text = EMPTY_COLOR;
	end;

	if self:GetNWString("slot9") != "空" then
		slot9Text = TEXT_COLOR;
	else
		slot9Text = EMPTY_COLOR;
	end;

    
    --按指定的度数旋转指定轴周围的角度。
    ang:RotateAroundAxis(ang:Up(), 180 );   --保持上下旋转都在这个面
    ang:RotateAroundAxis(ang:Forward(), 90);    --保持前后旋转都在这个面

    if self:GetPos():Distance( LocalPlayer():GetPos() ) > 256 then return end   --玩家距离多少时3Dui不可见
        --鼠标移到到按钮改变颜色
		if LocalPlayer():GetEyeTrace().Entity:GetClass() == self:GetClass() then
			if LocalPlayer():GetPos():Distance(self:GetPos()) < 72 then
				if !self:GetNWBool("locked") then
					if LocalPlayer():GetEyeTrace().HitPos:Distance(slot1Pos) < 4 then
						slot1Color = ACTIVE_COLOR
                    elseif LocalPlayer():GetEyeTrace().HitPos:Distance(slot2Pos) < 4 then
                        slot2Color = ACTIVE_COLOR
                    elseif LocalPlayer():GetEyeTrace().HitPos:Distance(slot3Pos) < 4 then
                        slot3Color = ACTIVE_COLOR
                    elseif LocalPlayer():GetEyeTrace().HitPos:Distance(slot4Pos) < 4 then
                        slot4Color = ACTIVE_COLOR
                    elseif LocalPlayer():GetEyeTrace().HitPos:Distance(slot5Pos) < 4 then
                        slot5Color = ACTIVE_COLOR
                    elseif LocalPlayer():GetEyeTrace().HitPos:Distance(slot6Pos) < 4 then
                        slot6Color = ACTIVE_COLOR
                    elseif LocalPlayer():GetEyeTrace().HitPos:Distance(slot7Pos) < 4 then
                        slot7Color = ACTIVE_COLOR
                    elseif LocalPlayer():GetEyeTrace().HitPos:Distance(slot8Pos) < 4 then
                        slot8Color = ACTIVE_COLOR
                    elseif LocalPlayer():GetEyeTrace().HitPos:Distance(slot9Pos) < 4 then
                        slot9Color = ACTIVE_COLOR
                    end
                end
			end
		end
        --                    实际向下移动      实际向自己移动
        cam.Start3D2D( pos + ang:Right() * -6 + ang:Up() * 5 , ang, 0.5 )
        
            --第一槽背景
            surface.SetDrawColor( BACKGROUND_COLOR );
            surface.DrawRect( -92, -69, 184, 10 );
            --描边
            surface.SetDrawColor( BORDER_COLOR );
            surface.DrawOutlinedRect( -92, -69, 184, 10 );

            --商品标签1
            surface.SetDrawColor( BACKGROUND_COLOR );
            surface.DrawRect( -82, -69, 27, 10 );
            --描边
            surface.SetDrawColor( BORDER_COLOR );
            surface.DrawOutlinedRect( -82, -69, 27, 10 ); 

            --商品标签2
            surface.SetDrawColor( BACKGROUND_COLOR );
            surface.DrawRect( 65, -69, 27, 10 );
            --描边
            surface.SetDrawColor( BORDER_COLOR );
            surface.DrawOutlinedRect( 65, -69, 27, 10 );
        
        cam.End3D2D();

        --字体/按钮等
        cam.Start3D2D( pos + ang:Forward() * -14 + ang:Right() * -20 + ang:Up() * 5 , ang, 0.3 )

            --标签1框
            surface.SetDrawColor( BORDER_COLOR );
            surface.DrawOutlinedRect( -89, -68, 27, 9 )

            --标签2框
            surface.SetDrawColor( BORDER_COLOR );
            surface.DrawOutlinedRect( 156, -68, 27, 9 )

        cam.End3D2D();

        --按钮
        cam.Start3D2D( pos + ang:Forward() * -14 + ang:Right() * -20 + ang:Up() * 5 , ang, 0.07 )
            if ( self:GetNWString( "slot1" ) != "空" ) then
                --1
                surface.SetDrawColor(slot1Color)
                draw.SimpleTextOutlined( "物品", "buttontext1", -325, -280, slot1Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )
                draw.SimpleTextOutlined( "购买", "buttontext2", -322, -252, slot1Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )
            else
                --1
                surface.SetDrawColor(slot1Text)
                draw.SimpleTextOutlined( "物品", "buttontext1", -325, -280, slot1Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )
                draw.SimpleTextOutlined( "购买", "buttontext2", -322, -252, slot1Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )
            end
            surface.DrawOutlinedRect(-372, -251, 100, 20);

            if ( self:GetNWString( "slot2" ) != "空" ) then
                --2
                surface.SetDrawColor(slot2Color)
                draw.SimpleTextOutlined( "物品", "buttontext1", 725, -280, slot2Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )
                draw.SimpleTextOutlined( "购买", "buttontext2", 728, -252, slot2Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )
            else
                --2
                surface.SetDrawColor(slot2Text)
                draw.SimpleTextOutlined( "物品", "buttontext1", 725, -280, slot2Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )
                draw.SimpleTextOutlined( "购买", "buttontext2", 728, -252, slot2Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )
            end
            surface.DrawOutlinedRect(678, -251, 100, 20);
    
        cam.End3D2D();

        --货架——中层
        cam.Start3D2D( pos + ang:Up() * 9 , ang, 0.5 )

            --第二槽背景
            surface.SetDrawColor( BACKGROUND_COLOR );
            surface.DrawRect( -92, -54, 184, 10 );
            --描边
            surface.SetDrawColor( BORDER_COLOR );
            surface.DrawOutlinedRect( -92, -54, 184, 10 );

            --商品标签1
            surface.SetDrawColor( BACKGROUND_COLOR );
            surface.DrawRect( -82, -54, 27, 10 );
            --描边
            surface.SetDrawColor( BORDER_COLOR );
            surface.DrawOutlinedRect( -82, -54, 27, 10 ); 

            --商品标签2
            surface.SetDrawColor( BACKGROUND_COLOR );
            surface.DrawRect( 65, -54, 27, 10 );
            --描边
            surface.SetDrawColor( BORDER_COLOR );
            surface.DrawOutlinedRect( 65, -54, 27, 10 );  

            --字体/按钮等
            cam.Start3D2D( pos + ang:Forward() * -14 + ang:Right() * -10 + ang:Up() * 9 , ang, 0.3 )

                --标签1框
                surface.SetDrawColor( BORDER_COLOR );
                surface.DrawOutlinedRect( -89, -56, 27, 9 )

                --标签2框
                surface.SetDrawColor( BORDER_COLOR );
                surface.DrawOutlinedRect( 156, -56, 27, 9 )

                --按钮
                cam.Start3D2D( pos + ang:Forward() * -14 + ang:Right() * -10 + ang:Up() * 9 , ang, 0.07 )
                    if ( self:GetNWString( "slot3" ) != "空" ) then
                        --1
                        surface.SetDrawColor(slot3Color)
                        draw.SimpleTextOutlined( "物品", "buttontext1", -325, -228, slot3Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )
                        draw.SimpleTextOutlined( "购买", "buttontext2", -322, -201, slot3Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )

                    else
                        --1
                        surface.SetDrawColor(slot3Text)
                        draw.SimpleTextOutlined( "物品", "buttontext1", -325, -228, slot3Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )
                        draw.SimpleTextOutlined( "购买", "buttontext2", -322, -201, slot3Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )
                    end
                    surface.DrawOutlinedRect(-372, -200, 100, 20);

                    if ( self:GetNWString( "slot4" ) != "空" ) then
                        --2
                        surface.SetDrawColor(slot4Color)
                        draw.SimpleTextOutlined( "物品", "buttontext1", 725, -228, slot4Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )
                        draw.SimpleTextOutlined( "购买", "buttontext2", 728, -201, slot4Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )
                    else
                        --2
                        surface.SetDrawColor(slot4Text)
                        draw.SimpleTextOutlined( "物品", "buttontext1", 725, -228, slot4Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )
                        draw.SimpleTextOutlined( "购买", "buttontext2", 728, -201, slot4Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )
                    end
                    surface.DrawOutlinedRect(678, -200, 100, 20);

                cam.End3D2D();

            cam.End3D2D();

        cam.End3D2D();

        --货架——底层
        cam.Start3D2D( pos + ang:Up() * 21 , ang + Angle( 0, 0, -19 ), 0.5 )

            --第三槽背景
            surface.SetDrawColor( BACKGROUND_COLOR );
            surface.DrawRect( -92, -39, 184, 10 );
            --描边
            surface.SetDrawColor( BORDER_COLOR );
            surface.DrawOutlinedRect( -92, -39, 184, 10 );

            --商品标签1
            surface.SetDrawColor( BACKGROUND_COLOR );
            surface.DrawRect( -82, -39, 27, 10 );
            --描边
            surface.SetDrawColor( BORDER_COLOR );
            surface.DrawOutlinedRect( -82, -39, 27, 10 );  

            --商品标签2
            surface.SetDrawColor( BACKGROUND_COLOR );
            surface.DrawRect( -46, -39, 27, 10 );
            --描边
            surface.SetDrawColor( BORDER_COLOR );
            surface.DrawOutlinedRect( -46, -39, 27, 10 ); 
        
            --商品标签3
            surface.SetDrawColor( BACKGROUND_COLOR );
            surface.DrawRect( -9, -39, 27, 10 );
            --描边
            surface.SetDrawColor( BORDER_COLOR );
            surface.DrawOutlinedRect( -9, -39, 27, 10 );

            --商品标签4
            surface.SetDrawColor( BACKGROUND_COLOR );
            surface.DrawRect( 28, -39, 27, 10 );
            --描边
            surface.SetDrawColor( BORDER_COLOR );
            surface.DrawOutlinedRect( 28, -39, 27, 10 );       
            
            --商品标签5
            surface.SetDrawColor( BACKGROUND_COLOR );
            surface.DrawRect( 65, -39, 27, 10 );
            --描边
            surface.SetDrawColor( BORDER_COLOR );
            surface.DrawOutlinedRect( 65, -39, 27, 10 );          
            
            --字体/按钮等
            cam.Start3D2D( pos + ang:Forward() * -16 + ang:Up() * 21 , ang + Angle( 0, 0, -19 ), 0.3 )

                --标签1框
                surface.SetDrawColor( BORDER_COLOR );
                surface.DrawOutlinedRect( -83, -64, 27, 9 )

                --标签2框
                surface.SetDrawColor( BORDER_COLOR );
                surface.DrawOutlinedRect( -23, -64, 27, 9 )

                --标签3框
                surface.SetDrawColor( BORDER_COLOR );
                surface.DrawOutlinedRect( 39, -64, 27, 9 )

                --标签4框
                surface.SetDrawColor( BORDER_COLOR );
                surface.DrawOutlinedRect( 100, -64, 27, 9 )

                --标签5框
                surface.SetDrawColor( BORDER_COLOR );
                surface.DrawOutlinedRect( 162, -64, 27, 9 )

                --按钮
                cam.Start3D2D( pos + ang:Forward() * -16 + ang:Up() * 21 , ang + Angle( 0, 0, -19 ), 0.07 )
                    if( self:GetNWString( "slot5" ) != "空" )then
                        --1
                        surface.SetDrawColor(slot5Color)
                        draw.SimpleTextOutlined( "物品", "buttontext1", -299, -263, slot5Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )
                        draw.SimpleTextOutlined( "购买", "buttontext2", -293, -236, slot5Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )
        
                    else
                        --1
                        surface.SetDrawColor(slot5Text)
                        draw.SimpleTextOutlined( "物品", "buttontext1", -299, -263, slot5Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )
                        draw.SimpleTextOutlined( "购买", "buttontext2", -293, -236, slot5Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )

                    end
                    surface.DrawOutlinedRect(-345, -235, 100, 20);

                    if ( self:GetNWString( "slot6") != "空" ) then
                        --2
                        surface.SetDrawColor(slot6Color)
                        draw.SimpleTextOutlined( "物品", "buttontext1", -42, -263, slot6Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )
                        draw.SimpleTextOutlined( "购买", "buttontext2", -39, -236, slot6Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )
                    else
                        --2
                        surface.SetDrawColor(slot6Text)
                        draw.SimpleTextOutlined( "物品", "buttontext1", -42, -263, slot6Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )
                        draw.SimpleTextOutlined( "购买", "buttontext2", -39, -236, slot6Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )                        
                    end
                    surface.DrawOutlinedRect(-88, -235, 100, 20);

                    if ( self:GetNWString( "slot7") != "空" ) then
                        --3
                        surface.SetDrawColor(slot7Color)
                        draw.SimpleTextOutlined( "物品", "buttontext1", 223, -263, slot7Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )
                        draw.SimpleTextOutlined( "购买", "buttontext2", 229, -236, slot7Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )
                    else
                        --3
                        surface.SetDrawColor(slot7Text)
                        draw.SimpleTextOutlined( "物品", "buttontext1", 223, -263, slot7Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )
                        draw.SimpleTextOutlined( "购买", "buttontext2", 229, -236, slot7Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )
                    end
                    surface.DrawOutlinedRect(177, -235, 100, 20);

                    if ( self:GetNWString( "slot8") != "空" ) then
                        --4
                        surface.SetDrawColor(slot8Color)
                        draw.SimpleTextOutlined( "物品", "buttontext1", 486, -263, slot8Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )
                        draw.SimpleTextOutlined( "购买", "buttontext2", 490, -236, slot8Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )
                    else
                        --4
                        surface.SetDrawColor(slot8Text)
                        draw.SimpleTextOutlined( "物品", "buttontext1", 486, -263, slot8Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )
                        draw.SimpleTextOutlined( "购买", "buttontext2", 490, -236, slot8Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )
                    end
                    surface.DrawOutlinedRect(440, -235, 100, 20);

                    if ( self:GetNWString( "slot9") != "空" ) then
                        --5
                        surface.SetDrawColor(slot9Color)
                        draw.SimpleTextOutlined( "物品", "buttontext1", 751, -263, slot9Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )
                        draw.SimpleTextOutlined( "购买", "buttontext2", 755, -236, slot9Color, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 100 ) )            
                    else
                        --5
                        surface.SetDrawColor(slot9Text)
                        draw.SimpleTextOutlined( "物品", "buttontext1", 751, -263, slot9Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )
                        draw.SimpleTextOutlined( "购买", "buttontext2", 755, -236, slot9Text, TEXT_ALIGN_CENTER, TEXT_ALIGN_LEFT, 0, Color( 25, 25, 255, 1 ) )     
                    end
                    surface.DrawOutlinedRect(705, -235, 100, 20);

                cam.End3D2D();

            cam.End3D2D();

        cam.End3D2D();
    
        --测量跟踪范围用的线
        render.SetMaterial( Material( "cable/redlaser" ) )
        --1.1 beam                            --实际往上              实际往前                实际往右      
        render.DrawBeam( self:GetPos() + self:GetUp() *38 + self:GetRight() *-5 + self:GetForward() *43.3 ,self:GetPos() + self:GetUp() *38 + self:GetRight() *-10 + self:GetForward() *43.3, 1, 1, 1,Color( 255, 0, 0, 0 ) )
        --1.2
        render.DrawBeam( self:GetPos() + self:GetUp() *38 + self:GetRight() *-5 + self:GetForward() *-30 ,self:GetPos() + self:GetUp() *38 + self:GetRight() *-10 + self:GetForward() *-30, 1, 1, 1,Color( 255, 0, 0, 0 ) )
        --2.1
        render.DrawBeam( self:GetPos() + self:GetUp() *24.5 + self:GetRight() *-9 + self:GetForward() *43.3 ,self:GetPos() + self:GetUp() *24.5 + self:GetRight() *-14 + self:GetForward() *43.3, 1, 1, 1,Color( 255, 0, 0, 0 ) )
        --2.2
        render.DrawBeam( self:GetPos() + self:GetUp() *24.5 + self:GetRight() *-9 + self:GetForward() *-30 ,self:GetPos() + self:GetUp() *24.5 + self:GetRight() *-14 + self:GetForward() *-30, 1, 1, 1,Color( 255, 0, 0, 0 ) )
        --3.1
        render.DrawBeam( self:GetPos() + self:GetUp() *16 + self:GetRight() *-15 + self:GetForward() *43.3 ,self:GetPos() + self:GetUp() *16 + self:GetRight() *-20 + self:GetForward() *43.3, 1, 1, 1,Color( 255, 0, 0, 0 ) )
        --3.2
        render.DrawBeam( self:GetPos() + self:GetUp() *16 + self:GetRight() *-15 + self:GetForward() *25.3 ,self:GetPos() + self:GetUp() *16 + self:GetRight() *-20 + self:GetForward() *25.3, 1, 1, 1,Color( 255, 0, 0, 0 ) )
        --3.3
        render.DrawBeam( self:GetPos() + self:GetUp() *16 + self:GetRight() *-15 + self:GetForward() *7 ,self:GetPos() + self:GetUp() *16 + self:GetRight() *-20 + self:GetForward() *7, 1, 1, 1,Color( 255, 0, 0, 0 ) )
        --3.4
        render.DrawBeam( self:GetPos() + self:GetUp() *16 + self:GetRight() *-15 + self:GetForward() *-11.5 ,self:GetPos() + self:GetUp() *16 + self:GetRight() *-20 + self:GetForward() *-11.5, 1, 1, 1,Color( 255, 0, 0, 0 ) )
        --3.5
        render.DrawBeam( self:GetPos() + self:GetUp() *16 + self:GetRight() *-15 + self:GetForward() *-30 ,self:GetPos() + self:GetUp() *16 + self:GetRight() *-20 + self:GetForward() *-30, 1, 1, 1,Color( 255, 0, 0, 0 ) )

        --测量按钮用的点
        render.SetMaterial( Material( "sprites/glow04_noz" ) )
        --1.1
        render.DrawSprite( slot1Pos, 2, 2, Color( 255, 255, 255 ) )
        --1.2
        render.DrawSprite( slot2Pos, 2, 2, Color( 255, 255, 255 ) )
        --2.1
        render.DrawSprite( slot3Pos, 2, 2, Color( 255, 255, 255 ) )
        --2.2
        render.DrawSprite( slot4Pos, 2, 2, Color( 255, 255, 255 ) )
        --3.1
        render.DrawSprite( slot5Pos, 2, 2, Color( 255, 255, 255 ) )
        --3.2
        render.DrawSprite( slot6Pos, 2, 2, Color( 255, 255, 255 ) )
        --3.3
        render.DrawSprite( slot7Pos, 2, 2, Color( 255, 255, 255 ) )
        --3.4
        render.DrawSprite( slot8Pos, 2, 2, Color( 255, 255, 255 ) )
        --3.5
        render.DrawSprite( slot9Pos, 2, 2, Color( 255, 255, 255 ) )

end


