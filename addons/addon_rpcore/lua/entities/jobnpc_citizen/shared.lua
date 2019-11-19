citizenNPCConfig = citizenNPCConfig or {}

citizenNPCConfig.HeaderText			= "公民"    --npc名
citizenNPCConfig.HeaderTextColor	= Color( 255, 255, 255, 255 )

citizenNPCConfig.NpcModel 		    = "models/humans/Group01/Male_04.mdl" --Model of the NPC

citizenNPCConfig.SoundWelcome		= "vo/npc/male01/answer34.wav" --The sound when you press E on NPC.

citizenNPCConfig.AimTeam           = 1

--[[local npcConfig = { 
    doctor = "models/humans/group03m/female_01.mdl",
    poilce = "models/ratdock/ceiling_spiders_armored.mdl",
}
local init = {}
for k, v in pairs( npcConfig ) do
    init[k] = { 
        models = v 
    }
end

local tab = util.TableToJSON( init )
file.CreateDir( "jobnpc" )
file.Write( "jobnpc/init.txt", tab )
--]]

ENT.Type	    			= "ai"			--类
ENT.Base	    			= "base_ai"		--基础
ENT.PrintName				= "citizen_jobnpc"		--名称
ENT.Category				= "nxrp" 		--类别名称
ENT.Author 					= "N/A"			--作者
ENT.Contact					= ""
ENT.Instructions			= "工作更换"		--介绍
ENT.Spawnable				= true			--可以生成
ENT.AdminSpawnable			= true			--管理员生成
ENT.AutomaticFrameAdvance	= true			--是否设置自动框架推进

--function ENT:SetAutomaticFrameAdvance(byUsingAnim)
--	self.AutomaticFrameAdvance = byUsingAnim
--end
