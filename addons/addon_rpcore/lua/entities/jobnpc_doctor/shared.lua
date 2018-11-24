doctorNPCConfig = doctorNPCConfig or {}

doctorNPCConfig.TeamID              = "doctor"         --玩家将成为的工作id
doctorNPCConfig.HeaderText			= "医生"    --npc名

doctorNPCConfig.HeaderTextColor	= Color( 255, 255, 255, 255 )
--招牌信息
doctorNPCConfig.jobname             = "医生"        --职业名
doctorNPCConfig.jobable             = "急救，医疗，救护车"            --职能
doctorNPCConfig.jobpayday           = "100-200"     --发薪日
doctorNPCConfig.jobtaskpay          = "单次130"     --任务结算
doctorNPCConfig.jobperm             = "未定"            --职业权限
                    --看这是这一行最长的字符了,请注意.
--就职--按钮npc对话词                    
doctorNPCConfig.text1 = "emm."
doctorNPCConfig.text2 = "商店缺人手需要帮忙了"
doctorNPCConfig.text3 = "还有什么事直接说."
--聊聊天--按钮npc对话词
doctorNPCConfig.buttontext1         = "聊聊天"
doctorNPCConfig.text4 = "选这么久.妈的智障,快选啊"
doctorNPCConfig.text5 = "你浪费了我npc的生命!"
doctorNPCConfig.text6 = "聊聊天"
--其他--按钮npc对话词
doctorNPCConfig.buttontext3         = "其他"
doctorNPCConfig.text7 = "选这么久.妈的智障,快选啊"
doctorNPCConfig.text8 = "你浪费了我npc的生命!"
doctorNPCConfig.text9 = "其他"
--任务--按钮npc对话词
doctorNPCConfig.buttontext2         = "任务"
doctorNPCConfig.text10 = "选这么久.妈的智障,快选啊"
doctorNPCConfig.text11 = "你浪费了我npc的生命!"
doctorNPCConfig.text12 = "任务"
--辞职--按钮npc对话词
doctorNPCConfig.text13 = "选这么久.妈的智障,快选啊"
doctorNPCConfig.text14 = "你浪费了我npc的生命!"
doctorNPCConfig.text15 = "辞职"
--默认npc对话词
doctorNPCConfig.text16 = "选这么久.妈的智障,快选啊"
doctorNPCConfig.text17 = "你浪费了我npc的生命!"
doctorNPCConfig.text18 = "辞职"

doctorNPCConfig.text19 = "emmm"
doctorNPCConfig.text20 = "你已经有别的职业了"
doctorNPCConfig.text21 = "先去辞职再过来干吧!"

doctorNPCConfig.HeaderOutline		= true --whether or not to draw rectangle outline
doctorNPCConfig.HeaderOutlineColour	= Color( 2, 2, 2, 200 ) --Outline rectangle color

doctorNPCConfig.Color_1 			= Color( 189, 195, 199, 255 ) -- Outline Colour
doctorNPCConfig.Color_2 			= Color( 52, 73, 94, 255 ) -- Main Background Colour

doctorNPCConfig.ButtonColor_1 		= Color( 67, 176, 92, 255 ) -- 默认颜色
doctorNPCConfig.ButtonColor_2		    = Color( 35, 162, 77, 255 ) -- 停留颜色

doctorNPCConfig.ButtonColor_3 		= Color( 255, 183, 79, 255 ) -- 默认颜色
doctorNPCConfig.ButtonColor_4		    = Color( 255, 154, 0, 255 ) -- 停留颜色


doctorNPCConfig.MenuTextColor		= Color( 0, 0, 0, 255) -- Menu Text Color
doctorNPCConfig.ButtonTextColor		= Color( 255, 255, 255, 255) -- Button Text Color

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
