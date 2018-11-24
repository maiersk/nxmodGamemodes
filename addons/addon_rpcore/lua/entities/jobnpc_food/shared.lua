foodNPCConfig = foodNPCConfig or {}

foodNPCConfig.HeaderText			= "食材购买"    --npc名
foodNPCConfig.HeaderTextColor	= Color( 255, 255, 255, 255 )
--招牌信息
foodNPCConfig.plyinfo				= "使用容器装着(有加工)食材售出，希望你有个好价格"
foodNPCConfig.limit             	= "食物一定要用货架类装着不然容易烂掉,"
foodNPCConfig.faq           		= "食物可自动固定货架中.按R取消固定/再按一次可固定,固定状态会变色"     --发薪日

                    --看这是这一行最长的字符了,请注意.
--默认npc对话词
foodNPCConfig.text1 = "未命名："
foodNPCConfig.text2 = "    一天又一天没厌倦吧?"
foodNPCConfig.text3 = "    食材不够就通知加哦."

foodNPCConfig.HeaderOutline		= true --whether or not to draw rectangle outline
foodNPCConfig.HeaderOutlineColour	= Color( 2, 2, 2, 200 ) --Outline rectangle color

foodNPCConfig.Color_1 			= Color( 189, 195, 199, 255 ) -- Outline Colour
foodNPCConfig.Color_2 			= Color( 52, 73, 94, 255 ) -- Main Background Colour

foodNPCConfig.ButtonColor_1 		= Color( 67, 176, 92, 255 ) -- 默认颜色
foodNPCConfig.ButtonColor_2		    = Color( 35, 162, 77, 255 ) -- 停留颜色

foodNPCConfig.ButtonColor_3 		= Color( 255, 183, 79, 255 ) -- 默认颜色
foodNPCConfig.ButtonColor_4		    = Color( 255, 154, 0, 255 ) -- 停留颜色


foodNPCConfig.MenuTextColor		= Color( 0, 0, 0, 255) -- Menu Text Color
foodNPCConfig.ButtonTextColor		= Color( 255, 255, 255, 255) -- Button Text Color

foodNPCConfig.NpcModel 		    = "models/Humans/Group02/Female_04.mdl" --Model of the NPC

foodNPCConfig.SoundWelcome		= "vo/npc/female01/upthere02.wav" --The sound when you press E on NPC.

foodNPCConfig.AimTeam           = 1

items.food = {}

for key, value in pairs( items.foodTable ) do
	--PrintTable(value)
	if value.models ~= "none" then
		items.food[key] = {
			name = key,
			class = value.class,
			models = value.models,
			cost = value.cost,
			price = value.price, 
			textinfo = value.textinfo,
			isbox = value.isbox,
		}
	end
end

ENT.Type	    			= "ai"			--类
ENT.Base	    			= "base_ai"		--基础
ENT.PrintName				= "food_jobnpc"		--名称
ENT.Category				= "nxrp" 		--类别名称
ENT.Author 					= "N/A"			--作者
ENT.Contact					= ""
ENT.Instructions			= "工作更换"		--介绍
ENT.Spawnable				= true			--可以生成
ENT.AdminSpawnable			= true			--管理员生成
ENT.AutomaticFrameAdvance	= true			--是否设置自动框架推进
