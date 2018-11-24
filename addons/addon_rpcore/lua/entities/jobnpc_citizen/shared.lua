citizenNPCConfig = citizenNPCConfig or {}

citizenNPCConfig.TeamID              = "citizen"         --玩家将成为的工作id
citizenNPCConfig.HeaderText			= "公民"    --npc名
citizenNPCConfig.HeaderTextColor	= Color( 255, 255, 255, 255 )
--招牌信息
citizenNPCConfig.jobname             = "公民"        --职业名
citizenNPCConfig.jobpayday           = "100-200"     --发薪日
                    --看这是这一行最长的字符了,请注意.
--就职--按钮npc对话词                    
citizenNPCConfig.text1 = "未命名："
citizenNPCConfig.text2 = "     你确定要这份工作了吗"
citizenNPCConfig.text3 = "     不要嫌弃喔."
--聊聊天--按钮npc对话词
citizenNPCConfig.buttontext1         = "聊聊天"
citizenNPCConfig.text4 = "未命名："
citizenNPCConfig.text5 = "     文明游戏,愉快游玩"
citizenNPCConfig.text6 = "     注意自己的游戏行为,和谐游玩"
--其他--按钮npc对话词
citizenNPCConfig.buttontext3         = "任务"
citizenNPCConfig.text7 = "未命名："
citizenNPCConfig.text8 = "     你浪费了我npc的生命!"
citizenNPCConfig.text9 = "     其他"
--辞职--按钮npc对话词
citizenNPCConfig.text13 = "未命名："
citizenNPCConfig.text14 = "    你辞掉的话会成为游客!"
citizenNPCConfig.text15 = "    很多东西都会玩不成的."
--默认npc对话词
citizenNPCConfig.text16 = "未命名："
citizenNPCConfig.text17 = "    一天又一天没厌倦吧?"
citizenNPCConfig.text18 = "    食材不够就通知加哦."

citizenNPCConfig.text19 = "未命名："
citizenNPCConfig.text20 = "    你已经有别的职业了"
citizenNPCConfig.text21 = "    先去辞职再过来干吧!"

citizenNPCConfig.HeaderOutline		= true --whether or not to draw rectangle outline
citizenNPCConfig.HeaderOutlineColour	= Color( 2, 2, 2, 200 ) --Outline rectangle color

citizenNPCConfig.Color_1 			= Color( 189, 195, 199, 255 ) -- Outline Colour
citizenNPCConfig.Color_2 			= Color( 52, 73, 94, 255 ) -- Main Background Colour

citizenNPCConfig.ButtonColor_1 		= Color( 67, 176, 92, 255 ) -- 默认颜色
citizenNPCConfig.ButtonColor_2		    = Color( 35, 162, 77, 255 ) -- 停留颜色

citizenNPCConfig.ButtonColor_3 		= Color( 255, 183, 79, 255 ) -- 默认颜色
citizenNPCConfig.ButtonColor_4		    = Color( 255, 154, 0, 255 ) -- 停留颜色


citizenNPCConfig.MenuTextColor		= Color( 0, 0, 0, 255) -- Menu Text Color
citizenNPCConfig.ButtonTextColor		= Color( 255, 255, 255, 255) -- Button Text Color

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
