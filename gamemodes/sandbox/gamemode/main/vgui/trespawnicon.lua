
local PANEL = {}

AccessorFunc( PANEL, "m_strModelName",	"ModelName" )
AccessorFunc( PANEL, "m_iSkin",			"SkinID" )
AccessorFunc( PANEL, "m_strBodyGroups",	"BodyGroup" )
AccessorFunc( PANEL, "m_strIconName",	"IconName" )

function PANEL:Init()

	self:SetDoubleClickingEnabled( false )
	self:SetText( "" )

	self.Icon = vgui.Create( "Material", self )
	self.Icon:SetMouseInputEnabled( false )
	self.Icon:SetKeyboardInputEnabled( false )
	self.Icon.AutoSize = false	--自动适应材质/贴图
	self:SetSize( 64, 64 )
	
	self.m_strBodyGroups = "000000000"

end

function PANEL:DoRightClick()

	local pCanvas = self:GetSelectionCanvas()
	if ( IsValid( pCanvas ) && pCanvas:NumSelectedChildren() > 0 ) then
		return hook.Run( "SpawnlistOpenGenericMenu", pCanvas )
	end

	self:OpenMenu()
end

function PANEL:DoClick()
end

function PANEL:OpenMenu()
end

function PANEL:Paint( w, h )

	self.OverlayFade = math.Clamp( ( self.OverlayFade or 0 ) - RealFrameTime() * 640 * 2, 0, 255 )

	if ( dragndrop.IsDragging() || !self:IsHovered() ) then return end

	self.OverlayFade = math.Clamp( self.OverlayFade + RealFrameTime() * 640 * 8, 0, 255 )

end

local border = 4
local border_w = 5
local matHover = Material( "gui/sm_hover.png", "nocull" )
local boxHover = GWEN.CreateTextureBorder( border, border, 64 - border * 2, 64 - border * 2, border_w, border_w, border_w, border_w, matHover )

function PANEL:PaintOver( w, h )

	if ( self.OverlayFade > 0 ) then
		boxHover( 0, 0, w, h, Color( 255, 255, 255, self.OverlayFade ) )
	end

	self:DrawSelections()

end

function PANEL:PerformLayout()

	if ( self:IsDown() && !self.Dragging ) then
		self.Icon:StretchToParent( 6, 6, 6, 6 )
	else
		self.Icon:StretchToParent( 0, 0, 0, 0 )
	end

end

function PANEL:SetSpawnIcon( name )
	self.m_strIconName = name
	self.Icon:SetSpawnIcon( name )
end

function PANEL:SetBodyGroup( k, v )

	if ( k < 0 ) then return end
	if ( k > 9 ) then return end
	if ( v < 0 ) then return end
	if ( v > 9 ) then return end

	self.m_strBodyGroups = self.m_strBodyGroups:SetChar( k + 1, v )

end

function PANEL:SetMaterial(matname)
	if ( !matname ) then debug.Trace() return end

	self.Icon:SetMaterial( matname )
	
end

function PANEL:SetTexture(treid)
	if ( !treid ) then debug.Trace() return end
	self.Icon:SetText("")
	self.Icon.Paint = function(self, w, h)
		surface.SetTexture( treid )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( 0, 0, w, h )
	end
	
end

function PANEL:RebuildSpawnIcon()

	self.Icon:RebuildSpawnIcon()

end

function PANEL:RebuildSpawnIconEx( t )

	self.Icon:RebuildSpawnIconEx( t )

end

function PANEL:ToTable( bigtable )

	local tab = {}

	tab.type = "model"
	tab.model = self:GetModelName()

	if ( self:GetSkinID() != 0 ) then
		tab.skin = self:GetSkinID()
	end

	if ( self:GetBodyGroup() != "000000000" ) then
		tab.body = "B" .. self:GetBodyGroup()
	end

	if ( self:GetWide() != 64 ) then
		tab.wide = self:GetWide()
	end

	if ( self:GetTall() != 64 ) then
		tab.tall = self:GetTall()
	end

	table.insert( bigtable, tab )

end

function PANEL:Copy()

	local copy = vgui.Create( "TreSpawnIcon", self:GetParent() )
	copy:SetModel( self:GetModelName(), self:GetSkinID() )
	copy:CopyBase( self )
	copy.DoClick = self.DoClick
	copy.OpenMenu = self.OpenMenu

	return copy

end

-- Icon has been editied, they changed the skin
-- what should we do?
function PANEL:SkinChanged( i )

	-- Change the skin, and change the model
	-- this way we can edit the spawnmenu....
	self:SetSkinID( i )
	self:SetModel( self:GetModelName(), self:GetSkinID(), self:GetBodyGroup() )

end

function PANEL:BodyGroupChanged( k, v )

	self:SetBodyGroup( k, v )
	self:SetModel( self:GetModelName(), self:GetSkinID(), self:GetBodyGroup() )

end

vgui.Register( "TreSpawnIcon", PANEL, "DButton" )