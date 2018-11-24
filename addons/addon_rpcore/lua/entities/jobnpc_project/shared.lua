projectNPCConfig = projectNPCConfig or {}

projectNPCConfig.TeamID              = "project"         --玩家将成为的工作id
projectNPCConfig.HeaderText			= "工程"    --npc名

projectNPCConfig.HeaderTextColor	= Color( 255, 255, 255, 255 )
--招牌信息
projectNPCConfig.jobname             = "工程"        --职业名
projectNPCConfig.jobable             = "打压黑帮，收复地区，维护秩序"            --职能
projectNPCConfig.jobpayday           = "160-300"     --发薪日
projectNPCConfig.jobtaskpay          = "单次200"     --任务结算
projectNPCConfig.jobperm             = "未定"            --职业权限
                    --看这是这一行最长的字符了,请注意.
--就职--按钮npc对话词                    
projectNPCConfig.text1 = "emm."
projectNPCConfig.text2 = "商店缺人手需要帮忙了"
projectNPCConfig.text3 = "还有什么事直接说."
--聊聊天--按钮npc对话词
projectNPCConfig.buttontext1         = "聊聊天"
projectNPCConfig.text4 = "选这么久.妈的智障,快选啊"
projectNPCConfig.text5 = "你浪费了我npc的生命!"
projectNPCConfig.text6 = "聊聊天"
--其他--按钮npc对话词
projectNPCConfig.buttontext3         = "其他"
projectNPCConfig.text7 = "选这么久.妈的智障,快选啊"
projectNPCConfig.text8 = "你浪费了我npc的生命!"
projectNPCConfig.text9 = "其他"
--任务--按钮npc对话词
projectNPCConfig.buttontext2         = "任务"
projectNPCConfig.text10 = "选这么久.妈的智障,快选啊"
projectNPCConfig.text11 = "你浪费了我npc的生命!"
projectNPCConfig.text12 = "任务"
--辞职--按钮npc对话词
projectNPCConfig.text13 = "选这么久.妈的智障,快选啊"
projectNPCConfig.text14 = "你浪费了我npc的生命!"
projectNPCConfig.text15 = "辞职"
--默认npc对话词
projectNPCConfig.text16 = "选这么久.妈的智障,快选啊"
projectNPCConfig.text17 = "你浪费了我npc的生命!"
projectNPCConfig.text18 = "辞职"

doctorNPCConfig.text19 = "emmm"
doctorNPCConfig.text20 = "你已经有别的职业了"
doctorNPCConfig.text21 = "先去辞职再过来干吧!"


projectNPCConfig.HeaderOutline		= true --whether or not to draw rectangle outline
projectNPCConfig.HeaderOutlineColour	= Color( 2, 2, 2, 200 ) --Outline rectangle color

projectNPCConfig.Color_1 			= Color( 189, 195, 199, 255 ) -- Outline Colour
projectNPCConfig.Color_2 			= Color( 52, 73, 94, 255 ) -- Main Background Colour

projectNPCConfig.ButtonColor_1 		= Color( 67, 176, 92, 255 ) -- 默认颜色
projectNPCConfig.ButtonColor_2		    = Color( 35, 162, 77, 255 ) -- 停留颜色

projectNPCConfig.ButtonColor_3 		= Color( 255, 183, 79, 255 ) -- 默认颜色
projectNPCConfig.ButtonColor_4		    = Color( 255, 154, 0, 255 ) -- 停留颜色


projectNPCConfig.MenuTextColor		= Color( 0, 0, 0, 255) -- Menu Text Color
projectNPCConfig.ButtonTextColor		= Color( 255, 255, 255, 255) -- Button Text Color

projectNPCConfig.NpcModel 		    = "models/humans/group03/male_08.mdl" --Model of the NPC

projectNPCConfig.SoundWelcome		= "vo/npc/vortigaunt/wellmet.wav" --The sound when you press E on NPC.

projectNPCConfig.AimTeam           = 1

--[[
items.proTool = {}

for k, data in pairs(items.projectTable) do
    items.proTool[k] = {
        name = k,
        clss = data.class,
        level = data.level,
        textinfo = data.textinfo,
        
    }
end
--]]


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
ENT.PrintName				= "project_jobnpc"		--名称
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
