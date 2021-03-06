include( "shared.lua" )
include ( "cl_hud.lua" )
include ( "vgui/menu_main.lua" )
include ( "vgui/columnsheet.lua" )
include ( "vgui/trespawnicon.lua" )

local path = GM.FolderName .. "/gamemode/main/modules/"
local _, folders = file.Find(path .. "*", "LUA")

for k, folder in SortedPairs(folders, true) do
    for _, file in SortedPairs(file.Find(path .. folder .. "/sh_*.lua", "LUA"), true) do
        include(path .. folder .. "/" .. file)
    end 

    for _, file in SortedPairs(file.Find(path .. folder .. "/cl_*.lua", "LUA"), true) do
        include(path .. folder .. "/" .. file)
    end 
end

concommand.Add("f1menu", function() 
    f1Menu = vgui.Create('menu_f1main') f1Menu:SetVisible(true) 
end)
concommand.Add("f4menu", function( ply, command ) 
    f4Menu = vgui.Create('menu_f4main') --f4Menu:SetVisible(true) 
end)

--PrintTable( ULib.ucl.groups )
--首次在服务器生成
net.Receive( "firstspawn", function() 
    local judge = net.ReadString()
    if ( judge == "GenderPlane" ) then
        if ( !Genderplane ) then
            Genderplane = vgui.Create( "Genderplane" )
            Genderplane:SetVisible( true )
            gui.EnableScreenClicker( true )
        end
        --[[
        if ( Genderplane:IsVisible() ) then
            --设置不可见，设置能鼠标触控
            Genderplane:SetVisible( true )
            gui.EnableScreenClicker( true )
        else
            --否则设置可见，设置不能鼠标触控
            Genderplane:SetVisible( false )
            gui.EnableScreenClicker( false )
        end 
        --]]
    else
        --如果f1不存在，创建窗口设置不可见
        if( !f1MainMenu ) then
            f1MainMenu = vgui.Create( "menu_f1main" )
            f1MainMenu:SetVisible( true )
            gui.EnableScreenClicker( true )
        end
        
        --如果f1不存在，创建窗口设置不可见
        if( !f1MainMenu ) then
            f1MainMenu = vgui.Create( "menu_f1main" )
            f1MainMenu:SetVisible( false )
        end
        --如果f1窗口是可见的
        if ( f1MainMenu:IsVisible() ) then
            --设置不可见，设置不能鼠标触控
            f1MainMenu:Remove()
            --f1MainMenu:SetVisible( false )
            gui.EnableScreenClicker( false )
        else
            --否则设置可见，设置能鼠标触控
            f1MainMenu = vgui.Create( "menu_f1main" )
            --f4MainMenu:SetVisible( true )
            gui.EnableScreenClicker( true )
        end 
        
    end 

end)

net.Receive( "f1help" , function()

    --如果f1不存在，创建窗口设置不可见
    if( !f1MainMenu ) then
        f1MainMenu = vgui.Create( "menu_f1main" )
        f1MainMenu:SetVisible( false )
    end
    --如果f1窗口是可见的
    if ( f1MainMenu:IsVisible() ) then
        --设置不可见，设置不能鼠标触控
        f1MainMenu:Remove()
        --f1MainMenu:SetVisible( false )
        gui.EnableScreenClicker( false )
    else
        --否则设置可见，设置能鼠标触控
        f1MainMenu = vgui.Create( "menu_f1main" )
        --f4MainMenu:SetVisible( true )
        gui.EnableScreenClicker( true )
    end 

    --如果f4存在，f4不可见
    if( f4MainMenu ) then
        f4MainMenu:Remove()     
    end
    --选择完性别后，激活f1面板时清除选择性别界面
    if( Genderplane ) then
        Genderplane:Remove()
    end 

end)

net.Receive( "f4menu" , function()
    if( !f4MainMenu ) then
        f4MainMenu = vgui.Create( "menu_f4main" )
        f4MainMenu:SetVisible( false )
    end
    if ( f4MainMenu:IsVisible() ) then
        f4MainMenu:Remove()
        gui.EnableScreenClicker( false )
    else
        f4MainMenu = vgui.Create( "menu_f4main" )
        --f4MainMenu:SetVisible( true )
        gui.EnableScreenClicker( true )
    end
    
    --如果f1存在，f1不可见
    if( f1MainMenu ) then
        f1MainMenu:Remove()    
    end

end)
