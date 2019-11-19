surface.CreateFont("leftbuttonfont", {
	font = "Roboto",
	size = 20,
	weight = 1,
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
})



local PANEL = {}
    --魔改官方[列单]dcolumnsheet.lua代码

    AccessorFunc( PANEL, "ActiveButton", "ActiveButton" )
    --主体
    function PANEL:Init()
        --创建装载button主体
        self.Navigation = vgui.Create( "DScrollPanel", self )
        self.Navigation:Dock( LEFT )
        self.Navigation:SetWidth( 150 ) --大小
        self.Navigation:DockMargin( 4, 5, 0, 5 ) --位置
        --这些大小位置都会影响或者限制button大小和位置
        self.Content = vgui.Create( "Panel", self )
        self.Content:Dock( FILL )

        self.Items = {}

    end

    function PANEL:UseButtonOnlyStyle()
        self.ButtonOnly = true
    end

    function PANEL:AddSheet( label, panel, material )

        if (!IsValid( panel ) ) then return end

        local Sheet = {}

        if ( self.ButtonOnly ) then
            Sheet.Button = vgui.Create( "DImageButton", self.Navigation )
        else
            Sheet.Button = vgui.Create( "DButton", self.Navigation )
        end

        Sheet.Button:SetImage( material )
        Sheet.Button.Target = panel
        Sheet.Button:SetText( label )
        Sheet.Button:Dock( TOP )
        
        Sheet.Button:DockMargin( 0, 0, 0, 5 )
        Sheet.Button:SetSize( 120, 50)
        Sheet.Button:SetFont( "leftbuttonfont" )
        function Sheet.Button:Paint( w, h )
            --如果按钮被按下
            if( Sheet.Button:IsDown() ) then
                Sheet.Button:SetColor( Color( 0, 0, 0 ) )
                draw.RoundedBox( 0, 0, 0, w, h, Color( 158, 163, 168) )
            --如果按钮有鼠标停留
            elseif( Sheet.Button:IsHovered() ) then
                Sheet.Button:SetColor( Color( 0, 0, 0 ) )
                draw.RoundedBox( 0, 0, 0, w, h, Color( 158, 163, 168) )
            else
                Sheet.Button:SetColor( Color( 255, 255, 255 ) )
                draw.RoundedBox( 0, 0, 0, w, h, Color( 36, 36, 36) )
            end
        end
        
        Sheet.Button.DoClick = function()
            self:SetActiveButton( Sheet.Button )
        end

        Sheet.Panel = panel
        Sheet.Panel:SetParent( self.Content )
        Sheet.Panel:SetVisible( false )

        if ( self.ButtonOnly ) then
            Sheet.Button:SizeToContents()
            --Sheet.Button:SetColor( Color( 150, 150, 150, 100 ) )
        end

        table.insert( self.Items, Sheet )

        if ( !IsValid( self.ActiveButton ) ) then
            self:SetActiveButton( Sheet.Button )
        end

    end

    function PANEL:SetActiveButton( active )

        if ( self.ActiveButton == active ) then return end

        if ( self.ActiveButton && self.ActiveButton.Target ) then
            self.ActiveButton.Target:SetVisible( false )
            self.ActiveButton:SetSelected( false )
            self.ActiveButton:SetToggle( false )
            --self.ActiveButton:SetColor( Color( 150, 150, 150, 100 ) )
        end

        self.ActiveButton = active
    active.Target:SetVisible( true )
    active:SetSelected( true )
    active:SetToggle( true )
        --active:SetColor( Color( 255, 255, 255, 255 ) )

        self.Content:InvalidateLayout()

end

derma.DefineControl( "ColumnSheet", "", PANEL, "Panel" )