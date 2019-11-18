InvenTool = {}

--[[/*
 *      Gives a random item from the shop to a player
 */--]]
function InvenTool.GiveRandomItem( ply )
        local items = Pointshop2.GetRegisteredItems( )
        local itemClass = table.Random( items )
        return ply:PS2_EasyAddItem( itemClass.className )
end
--GiveRandomItem( player.GetByID( 1 ) )

--[[/*
 *      Gives a item with the specified name to the player
 */--]]
function InvenTool.GiveItemByPrintName( ply, printName )
        local itemClass = Pointshop2.GetItemClassByPrintName( printName )
        if not itemClass then
                error( "Invalid item " .. tostring( printName ) )
        end
        return ply:PS2_EasyAddItem( itemClass.className )
end

--GiveItemByPrintName( player.GetByID( 1 ), "Pointshop Single Use Weapon Base" )
function InvenTool.GiveItemByClass( ply, printName )
    return ply:PS2_EasyAddItem( printName )
end
--GiveItemByClass(player.GetByID( 1 ), "weapon_357")
