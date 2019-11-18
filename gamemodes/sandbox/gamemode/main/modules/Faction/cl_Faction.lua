Faction = Faction or {}
Faction.gang = Faction.gang or {}
Faction.group.list = Faction.group.list or {}

--批量把得到的数据转成对象
function Faction:HandleObj(data)
    local obj, gang = {}, {}
    for i = 1, #data do
        obj = data[i]
        self.__index = self
        setmetatable(obj, self)
        table.insert(gang, obj)
    end
    return gang
end



NetOperating.AddReceive("faction_createmenu", function(len, ply)
    local menu = vgui.Create("faction_createmenu")
    menu:Content()
end)

local PANEL = {}

function PANEL:Init()
    self:SetSkin("NxMod_dialog_Style")
	self:SetSize(420, 200)
	self:Center()
	self:ShowCloseButton(true)
	self:MakePopup()
    self:SetTitle("创建帮派")
end

function PANEL:Content()
    local w, h = self:GetSize()
    local info = vgui.Create("DLabel", self)
    info:SetSize(75, 55)
    info:SetPos(20, 50)
    info:SetText("帮派名: \n\n\n" .. "颜色: ")

    function info:Paint( w, h )
        --draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 0 ) )
    end

    local text_name = vgui.Create("DTextEntry", self)
    text_name:SetSize(330, 25)
    text_name:SetPos(75, 45)

    local numbw_color_r = vgui.Create("DNumberWang", self)
    numbw_color_r:SetSize(40, 25)
    numbw_color_r:SetPos(75, 45 + 40)

    local numbw_color_g = vgui.Create("DNumberWang", self)
    numbw_color_g:SetSize(40, 25)
    numbw_color_g:SetPos(75 + 40 * 1.5, 45 + 40)

    local numbw_color_b = vgui.Create("DNumberWang", self)
    numbw_color_b:SetSize(40, 25)
    numbw_color_b:SetPos(75 + 40 * 3, 45 + 40)

    local color_picker = vgui.Create("DRGBPicker", self)
    color_picker:SetSize(30, 70)
    color_picker:SetPos(75 + 200, 45 + 40)

    local color_cube = vgui.Create("DColorCube", self)
    color_cube:SetSize(70, 70)
    color_cube:SetPos(75 + 230, 45 + 40)

    color_picker.OnChange = function(col)
        local rgba = col:GetRGB()
        color_cube:SetColor(Color(rgba.r, rgba.g, rgba.b))
    end

    color_cube.OnUserChanged = function(col)
        local rgba = col:GetRGB()
        numbw_color_r:SetText(rgba.r)
        numbw_color_g:SetText(rgba.g)
        numbw_color_b:SetText(rgba.b)
    end

    local createbut = vgui.Create("DButton", self)
    createbut:SetSize(200, 30)
    createbut:SetPos(w * 0.5 - (200 * 0.5), h * 0.82)
    createbut:SetFont("CloseCaption_Normal")
    createbut:SetText("创建 -" .. Faction.CREATEGANGMONEY .. "$")

    createbut.DoClick = function()
        local colorcheck = numbw_color_r:GetText() .. numbw_color_g:GetText() .. numbw_color_b:GetText()
        if (text_name:GetText() != "") then
            if (colorcheck != "000") then
                NetOperating.SendToServ("factoin_createmenu_create", {
                    name = text_name:GetText(),
                    color = {
                        r = numbw_color_r:GetText(),
                        g = numbw_color_g:GetText(),
                        b = numbw_color_b:GetText()
                    }
                })
            end
        end
    end
end

vgui.Register("faction_createmenu", PANEL, "DFrame")

NetOperating.AddReceive("Derma_Query_snedtocl", function()
    local data = net.ReadTable()
    Derma_Query("你收到了" .. "来自" .. data.opply:Nick() .. " 的邀请, 希望你能加入 " .. data.fName .. " 帮派",
        "邀请信息", 
        "接受", function() 
            local faction = Faction:getGang(data.opply:GetGangId())
            faction:JoinByid(LocalPlayer():SteamID(), nil)
        end, 
        "拒绝", function()
            print("你拒绝了邀请")
        end)
end)

--gui
NetOperating.AddReceive("faction_menu", function(len, ply) 
    local data = net.ReadTable()
    Faction.group.list = data.group
    
    local menu = vgui.Create("faction_menu")
    menu:Content(data)
end)



PANEL = {}

function PANEL:Init()
	self:SetSkin("NxMod_dialog_Style")
	self:SetSize(700, 380)
	self:Center()
	self:ShowCloseButton(true)
	self:MakePopup()
    self:SetTitle("帮派")
end

function PANEL:Content(data)
    local x, y = self:GetPos()
    local w, h = self:GetSize()
    local ply = LocalPlayer()
    local faction = ply:GetGang()
    if (!faction) then self:Remove() return end
    local plyinfo = faction:getMenubarInfo(ply)
    
    --选择页按钮背景
    local mainpanel = vgui.Create( "DPanel", self )
    mainpanel:SetPos( 0, 30 )
    mainpanel:SetSize( w - 3, h - 35 )
    --mainpanel:SetSize( x - 10, y - 35 -8)
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
    colsheet:AddSheet( "帮派信息", sheet1 )

    local info = vgui.Create("DLabel", sheet1)
    info:SetSize(200, 300)
    info:SetPos(10, 1)
    info:SetFont("Domain_hudinfo_SM")
    info:SetText("帮派名: " .. "\n\n" ..
    "帮主: " .. "\n\n" ..
    "等级: " .. "\n\n" ..
    "公款: " .. "\n\n" .. 
    "帮派颜色: ")

    local value = vgui.Create("DLabelEditable", sheet1)
    value:SetSize(200, 300)
    value:SetPos(150, 2)
    value:SetFont("Domain_hudinfo_SM")
    value:SetText(" \n\n" ..
    " " .. data.owner .. "\n\n" ..
    " " .. faction.level .. " 等待更新" .. "\n\n" ..
    " " .. "$" .. faction.cash  .. "\n\n" ..
    " ")

    local edit_value = vgui.Create("DTextEntry", sheet1)
    edit_value:SetSize(100, 25)
    edit_value:SetPos(150, 55)
    edit_value:SetFont("Domain_hudinfo_SM")
    edit_value:SetText(faction:getName())
    edit_value:SetEditable(false)

    edit_value.OnEnter = function()
        faction:SetName(edit_value:GetText())
    end

    local tpanel = vgui.Create("DPanel", sheet1)
    tpanel:SetSize(60, 30)
    tpanel:SetPos(x - 295, y - 40)
    tpanel.Paint = function(self, w, h)
        local fcol = faction:getColor()
        draw.RoundedBox( 0, 0, 0, w, h, Color( fcol.r, fcol.g, fcol.b, fcol.a ) )
    end

    -- local editbut = vgui.Create("DButton", sheet1)
    -- editbut:SetSize(45, 30)
    -- editbut:SetPos(250, 35)
    -- editbut:SetTextColor(Color(0, 0, 0, 0))
    -- editbut.Paint = function(self, w, h)
    --     draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 0))
    -- end
    local editbut

    editbut = vgui.Create("DButton", sheet1)
    editbut:SetSize(45, 30)
    editbut:SetPos(250, y - 80)
    editbut:SetText("存钱")
    editbut.DoClick = function()
        Derma_StringRequest("存钱到帮派", "", "", 
            function(text) 
                faction:SaveMoney(text)
            end, 
            function(text)
            end
        )
    end

    editbut = vgui.Create("DButton", sheet1)
    editbut:SetSize(45, 30)
    editbut:SetPos(300, y - 80)
    editbut:SetText("取钱")
    editbut.DoClick = function()
        Derma_StringRequest("从帮派取钱", "", "", 
            function(text) 
                faction:TakeMoney(text)
            end, 
            function(text)
            end
        )
    end

    local color_cube = vgui.Create("DColorCube", sheet1)
    color_cube:SetSize(75, 70)
    color_cube:SetPos(270, y - 40)
    color_cube:SetVisible(false)

    local color_picker = vgui.Create("DRGBPicker", sheet1)
    color_picker:SetSize(19, 70)
    color_picker:SetPos(250, y - 40)
    color_picker:SetVisible(false)

    color_picker.OnChange = function( col )
        local rgba = col:GetRGB()
        color_cube:SetColor(Color(rgba.r, rgba.g, rgba.b, rgba.a))
    end
    
    editbut = vgui.Create("DButton", sheet1)
    editbut:SetSize(50, 30)
    editbut:SetPos(350, y)
    editbut:SetText("修改颜色")
    editbut:SetVisible(false)

    editbut.DoClick = function()
        faction:SetColor(color_cube:GetRGB())
    end

    local exitbut = vgui.Create("DButton", sheet1)
    exitbut:SetSize(60, 30)
    exitbut:SetPos(465, 300)
    exitbut:SetText("退出帮派")
    exitbut:SetZPos(1)

    exitbut.DoClick = function()
        Derma_Query("是否确定退出帮派?", "提示", 
        "确定", function() 
            faction:ExitByid(plyinfo.id)
        end,
        "取消", function() 
        end)
    end

    local dropbut = vgui.Create("DButton", sheet1)
    dropbut:SetSize(60, 30)
    dropbut:SetPos(465, 300)
    dropbut:SetText("解散帮派")
    dropbut:SetVisible(false)
    dropbut:SetZPos(2)

    dropbut.DoClick = function()
        Derma_Query("是否确定解散帮派?", "提示", 
        "确定", function() 
            faction:Drop(plyinfo.id)
        end,
        "取消", function()
        end)
    end
    
    if (Faction.group:get(plyinfo.groupid).power >= Faction.group.SUPERADMIN) then
        color_cube:SetVisible(true)
        color_picker:SetVisible(true)
        editbut:SetVisible(true)
        edit_value:SetEditable(true)
        dropbut:SetVisible(true)
    end

    --创建选择页2
    local sheet2 = vgui.Create( "DPanel", colsheet )
    sheet2:Dock( FILL )
    sheet2.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
    end

    colsheet:AddSheet( "帮派成员", sheet2 )

    --配置表
    local dlisttbl = {}
    --表和控件数据
    local seldata = false

    local DList = vgui.Create( "DListView", sheet2 )
    --DList:SetSize(0, 290)
    DList:Dock( FILL )
    DList:SetMultiSelect( false )
    DList:AddColumn( "id" )
    DList:AddColumn( "名字" )
    DList:AddColumn( "权限组" )

    if (faction.menubar) then
        for k, v in pairs(faction.menubar) do
            DList:AddLine(v.id, v.name, Faction.group:get(v.groupid).group)
        end
    end

    local dinfo = vgui.Create("DLabel")
    -- dinfo:Dock(LEFT)
    dinfo:SetText("修改权限组")
    dinfo:SetVisible(false)

    local dcbox = vgui.Create("DComboBox")
    -- dcbox:Dock(LEFT)
    dcbox:SetText("权限组")
    dcbox:SetVisible(false)

    for group, v in pairs(Faction.group.list) do
        dcbox:AddChoice( group )
    end

    dcbox.OnSelect = function( self, index, value )
        if (seldata:IsValid()) then
            local id = seldata:GetValue(1)
            faction:ChangeGroup(id, value) 
            timer.Simple(1, function() 
                DList:Clear()
                faction = ply:GetGang()
                if (faction.menubar) then
                    for k, v in pairs(faction.menubar) do
                        DList:AddLine(v.id, v.name, Faction.group:get(v.groupid).group)
                    end
                end
            end)
        end
    end
    
    local butt = vgui.Create("DButton")
    butt:SetText("踢出")
    butt:SetVisible(false)

    butt.DoClick = function() 
        if (seldata:IsValid()) then
            local id = seldata:GetValue(1)
            faction:KickMenubar(id)
            timer.Simple(1, function() 
                DList:Clear()
                faction = ply:GetGang()
                if (faction.menubar) then
                    for k, v in pairs(faction.menubar) do
                        DList:AddLine(v.id, v.name, Faction.group:get(v.groupid).group)
                    end
                end
            end)
        end
    end

    dlisttbl[DList] = { dinfo, dcbox, butt }

    --创建选择页3
    local sheet3 = vgui.Create( "DPanel", colsheet )
    sheet3:Dock( FILL )
    sheet3.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
    end

    colsheet:AddSheet( "帮派领地", sheet3 )

    local dDList = vgui.Create( "DListView", sheet3 )
    --dDList:SetSize(0, 290)
    dDList:Dock( FILL )
    dDList:SetMultiSelect( false )
    dDList:AddColumn( "地名" )
    dDList:AddColumn( "描述" )
    --dDList:AddColumn( "group" )

    if (Domain.data) then
        for k, v in pairs(Domain.data) do
            if (v.factionid == faction.id) then
                dDList:AddLine(v.name, v.description)
            end
        end
    end

    butt = vgui.Create("DButton")
    butt:SetText("放弃领地")
    butt:SetVisible(false)

    butt.DoClick = function()
        if (seldata:IsValid()) then 
            local domname = seldata:GetValue(1)
        
            NetOperating.SendToServ("domain_cl_abandon", { name = domname })
            
            timer.Simple(1, function()
                dDList:Clear()
                if (Domain.data) then
                    for k, v in pairs(Domain.data) do
                        if (v.factionid == faction.id) then
                            dDList:AddLine(v.name, v.description)
                        end
                    end
                end
            end)
        end
    end

    dlisttbl[dDList] = { butt }
    
    --处理表所属按钮
    for k, v in pairs(dlisttbl) do
        if (k:IsValid()) then
            k.OnRowSelected = function( lst, index, pnl )
                if (Faction.group:get(plyinfo.groupid).power >= Faction.group.ADMIN) then
                    k:SetSize(0, 320)
                    k:Dock(BOTTOM)
                    
                    for _, com in pairs(v) do
                        if (!com:IsVisible()) then
                            com:SetParent(k:GetParent())
                            com:Dock(LEFT)
                            com:SetVisible(true)
                        end
                    end
                    seldata = pnl
                end
            end
            k.OnRowRightClick = function( lst, index, pnl )
                k:Dock(FILL)
            end
        end
    end

    --创建选择页4
    local sheet4 = vgui.Create( "DPanel", colsheet )
    sheet4:Dock( FILL )
    sheet4.Paint = function( self, w, h )
        draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
    end

    colsheet:AddSheet( "邀请玩家", sheet4 )
    
    local plylist = vgui.Create( "DListView", sheet4 )
    plylist:Dock( FILL )
    plylist:SetMultiSelect(false)
    plylist:AddColumn( "名" )
    plylist:AddColumn( "steamid" )
    plylist:AddColumn( "已有帮派" )
    
    for _, ply in pairs(player.GetAll()) do
        local hasgang
        if (ply:GetGangId() == nil) then
            hasgang = "无"
        else
            hasgang = "有"
        end
        plylist:AddLine(ply:Nick(), ply:SteamID(), hasgang)
    end

    plylist.OnRowRightClick = function( lst, index, pnl )
        local mx, my = gui.MouseX(), gui.MouseY()
        x, y = self:GetPos()

        local sltply = pnl:GetValue(2)

        if (self.rcmenu) then self.rcmenu:Remove() end
        local rcmenu = vgui.Create( "DPanel", self )
        self.rcmenu = rcmenu
        rcmenu:SetSize(80, 100)
        rcmenu:SetPos( mx - x, my - y)
        rcmenu:SetZPos(2)
        
        local invite = vgui.Create("DButton", rcmenu)
        invite:Dock( TOP )
        invite:SetText("邀请玩家")

        invite.DoClick = function()
            NetOperating.SendToServ("Derma_Query_invite_plytoGang", { steamid = sltply, fName = faction.name, fId = faction.id })
        end
    end

    plylist.OnRowSelected = function( lst, index, pnl )
        if (self.rcmenu) then
            self.rcmenu:Remove()
        end
    end

    if (ply:GetUserGroup() == "superadmin") then
        --创建选择页5
        local sheet5 = vgui.Create( "DPanel", colsheet )
        sheet5:Dock( FILL )
        sheet5.Paint = function( self, w, h )
            draw.RoundedBox( 0, 0, 0, w, h, Color( 0, 0, 0, 150 ) )
        end

        colsheet:AddSheet( "管理员", sheet5 ) 
        
        local Rpanel = vgui.Create( "DPanel", sheet5 )
        Rpanel:Dock( FILL )
        Rpanel:SetZPos(2)

        local mbList = vgui.Create( "DListView", Rpanel )
        mbList:SetSize(0, y / 1.5)
        mbList:Dock( TOP )
        mbList:SetMultiSelect( false )
        mbList:AddColumn( "名" )
        mbList:AddColumn( "id" )
        mbList:AddColumn( "权限组" )

        mbList.OnRowRightClick = function( lst, index, pnl )
            local mx, my = gui.MouseX(), gui.MouseY()
            x, y = self:GetPos()
            --print(mx, my, x, y)

            if (self.rcmenu) then self.rcmenu:Remove() end
            local rcmenu = vgui.Create( "DPanel", self )
            self.rcmenu = rcmenu
            rcmenu:SetSize(80, 100)
            rcmenu:SetPos( mx - x, my - y)
            rcmenu:SetZPos(2)
            
            local rcmenutext = vgui.Create( "DLabel", rcmenu )
            rcmenutext:Dock( TOP )
            rcmenutext:SetText( "管理玩家操作" )
            rcmenutext:SetColor( Color( 0, 0, 0 ) )

            local dcbox_cggroup = vgui.Create("DComboBox", rcmenu)
            dcbox_cggroup:Dock( TOP )
            dcbox_cggroup:SetText("权限组")
        
            for group, v in pairs(Faction.group.list) do
                dcbox_cggroup:AddChoice( group )
            end
        
            dcbox_cggroup.OnSelect = function( self, index, value )
                if (pnl:IsValid()) then
                    local id = pnl:GetValue(1)
                    faction:ChangeGroup(id, value) 
                    timer.Simple(1, function() 
                        mbList:Clear()
                        faction = ply:GetGang()
                        if (faction.menubar) then
                            for k, v in pairs(faction.menubar) do
                                mbList:AddLine(v.id, v.name, Faction.group:get(v.groupid).group)
                            end
                        end
                    end)
                end
            end
            
            local but_kick = vgui.Create("DButton", rcmenu)
            but_kick:Dock( TOP )
            but_kick:SetText("踢出")
        
            but_kick.DoClick = function() 
                if (pnl:IsValid()) then
                    local id = pnl:GetValue(1)
                    faction:KickMenubar(id)
                    timer.Simple(1, function() 
                        mbList:Clear()
                        faction = ply:GetGang()
                        if (faction) then
                            for k, v in pairs(faction.menubar) do
                                mbList:AddLine(v.id, v.name, Faction.group:get(v.groupid).group)
                            end
                        end
                    end)
                end
            end
            --print(rcmenu:GetPos())
        end

        mbList.OnRowSelected = function( lst, index, pnl )
            if (self.rcmenu) then
                self.rcmenu:Remove()
            end
        end

        local domianList = vgui.Create( "DListView", Rpanel )
        domianList:SetSize(0, y / 1.5)
        domianList:Dock( BOTTOM )
        domianList:SetMultiSelect( false )
        domianList:AddColumn( "地名" )
        domianList:AddColumn( "描述" )
        
        domianList.OnRowRightClick = function( lst, index, pnl )
            local mx, my = gui.MouseX(), gui.MouseY()
            x, y = self:GetPos()
            --print(mx, my, x, y)

            if (self.rcmenu) then self.rcmenu:Remove() end
            local rcmenu = vgui.Create( "DPanel", self )
            self.rcmenu = rcmenu
            rcmenu:SetSize(80, 100)
            rcmenu:SetPos( mx - x, my - y)
            rcmenu:SetZPos(2)
            
            local rcmenutext = vgui.Create( "DLabel", rcmenu )
            rcmenutext:Dock( TOP )
            rcmenutext:SetText( "管理地盘" )
            rcmenutext:SetColor( Color( 0, 0, 0 ) )
            
            local abandon = vgui.Create("DButton", rcmenu)
            abandon:Dock( TOP )
            abandon:SetText("放弃地盘")
        
            abandon.DoClick = function() 
                if (pnl:IsValid()) then
                    local domname = pnl:GetValue(1)
                
                    NetOperating.SendToServ("domain_cl_abandon", { name = domname })
                    
                    timer.Simple(1, function()
                        domianList:Clear()
                        if (Domain.data) then
                            for k, v in pairs(Domain.data) do
                                if (v.factionid == faction.id) then
                                    domianList:AddLine(v.name, v.description)
                                end
                            end
                        end
                    end)
                end
            end
            --print(rcmenu:GetPos())
        end

        local Lpanel = vgui.Create( "DPanel", sheet5 )
        Lpanel:Dock( LEFT )
        Lpanel:SetSize(192, 0)

        local gangList = vgui.Create( "DListView", Lpanel )
        gangList:Dock( FILL )
        gangList:SetMultiSelect( false )
        gangList:AddColumn( "ID" )
        gangList:AddColumn( "帮派名" )
        gangList:AddColumn( "帮主" )

        if (Faction.gang) then
            for k, v in pairs(Faction.gang) do
                local nick
                if (player.GetBySteamID(v.ownerid)) then
                    nick = player.GetBySteamID(v.ownerid):Nick()
                end
                gangList:AddLine(v.id, v.name, nick or v.ownerid)
            end
        end

        local adminselgang

        gangList.OnRowSelected = function( lst, index, pnl )
            mbList:Clear()
            domianList:Clear()
            adminselgang = Faction:getGang(pnl:GetValue(1))

            if (adminselgang) then
                for k, v in pairs(adminselgang.menubar) do
                    mbList:AddLine(v.id, v.name, Faction.group:get(v.groupid).group)
                end
            end

            if (adminselgang) then
                if (Domain.data) then
                    for k, v in pairs(Domain.data) do
                        if (v.factionid == adminselgang.id) then
                            domianList:AddLine(v.name, v.description)
                        end
                    end
                end
            end
        end

        local Lbpanel = vgui.Create( "DPanel", Lpanel )
        Lbpanel:Dock( BOTTOM )
        Lbpanel:SetSize(0, 20)

        But = vgui.Create( "DButton", Lbpanel )
        But:Dock( LEFT )
        But:SetText( "解散" )

        But.DoClick = function()
            Derma_Query("是否确定解散帮派?", "提示", 
            "确定", function() 
                adminselgang:Drop(plyinfo.id)
            end,
            "取消", function()
            end)
        end

        local editDcomBox = vgui.Create("DComboBox", Lbpanel)
        editDcomBox:Dock( LEFT )
        editDcomBox:SetText("修改帮派")
    
        editDcomBox:AddChoice( "帮名" )
        editDcomBox:AddChoice( "颜色" )
        editDcomBox:AddChoice( "公款" )
    
        editDcomBox.OnSelect = function( self, index, value )
            if (!adminselgang) then return end
            local func
            if (value == "帮名") then
                func = function(text)
                    adminselgang:SetName(text)
                end
            elseif (value == "颜色") then
                func = function(text)
                    local rgb = string.Split(text, ",")
                    local color = Color(rgb[1], rgb[2], rgb[3])
                    adminselgang:SetColor(color)
                end
            elseif (value == "公款") then
                func = function(text)
                    print(text)
                end
            end
            Derma_StringRequest("设置 " .. value, "", "", 
                func, 
                function(text)
                end
            )
        end
        
    end
end

vgui.Register("faction_menu", PANEL, "DFrame")