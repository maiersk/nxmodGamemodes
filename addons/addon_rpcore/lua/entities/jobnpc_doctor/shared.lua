doctorNPCConfig = doctorNPCConfig or {}

doctorNPCConfig.HeaderText			= "医生"    --npc名
doctorNPCConfig.HeaderTextColor	= Color( 255, 255, 255, 255 )

doctorNPCConfig.NpcModel 		    = "models/humans/group03m/female_01.mdl" --Model of the NPC

doctorNPCConfig.SoundWelcome		= "vo/npc/female01/health01.wav" --The sound when you press E on NPC.

doctorNPCConfig.AimTeam           = 1

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
ENT.PrintName				= "doctor_jobnpc"		--名称
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
