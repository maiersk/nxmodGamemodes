npccreateNPCConfig = npccreateNPCConfig or {}

npccreateNPCConfig.HeaderText			= "NPC招募"    --npc名
npccreateNPCConfig.HeaderTextColor	= Color( 255, 255, 255, 255 )
--招牌信息
npccreateNPCConfig.plyinfo				= "招募npc跟随自己一起干！"
npccreateNPCConfig.limit             	= "每个玩家只允许4个npc跟随"
npccreateNPCConfig.faq           		= "遇到bug/问题/建议直接反馈给腐竹"     --发薪日

                    --看这是这一行最长的字符了,请注意.
--默认npc对话词
npccreateNPCConfig.text1 = "未命名："
npccreateNPCConfig.text2 = "    喜欢的看好就选吧!"
npccreateNPCConfig.text3 = "    会不断加npc的了不要急."

npccreateNPCConfig.HeaderOutline		= true --whether or not to draw rectangle outline
npccreateNPCConfig.HeaderOutlineColour	= Color( 2, 2, 2, 200 ) --Outline rectangle color

npccreateNPCConfig.Color_1 			= Color( 189, 195, 199, 255 ) -- Outline Colour
npccreateNPCConfig.Color_2 			= Color( 52, 73, 94, 255 ) -- Main Background Colour

npccreateNPCConfig.ButtonColor_1 		= Color( 67, 176, 92, 255 ) -- 默认颜色
npccreateNPCConfig.ButtonColor_2		    = Color( 35, 162, 77, 255 ) -- 停留颜色

npccreateNPCConfig.ButtonColor_3 		= Color( 255, 183, 79, 255 ) -- 默认颜色
npccreateNPCConfig.ButtonColor_4		    = Color( 255, 154, 0, 255 ) -- 停留颜色


npccreateNPCConfig.MenuTextColor		= Color( 0, 0, 0, 255) -- Menu Text Color
npccreateNPCConfig.ButtonTextColor		= Color( 255, 255, 255, 255) -- Button Text Color

npccreateNPCConfig.NpcModel 		    = "models/humans/Group01/Male_04.mdl" --Model of the NPC

npccreateNPCConfig.SoundWelcome		= "vo/npc/male01/answer39.wav" --The sound when you press E on NPC.

npccreateNPCConfig.AimTeam           = 1

items.npc = {}

for key, value in pairs(items.npcTable) do
	--PrintTable(value)
	if value.models ~= "none" then
		items.npc[key] = {
			name = key,
			class = value.class,
			models = value.models,
			img = value.img,
			price = value.price, 
			textinfo = value.textinfo,
			Weapons = value.Weapons,
			SpawnFlags = value.SpawnFlags,
		}
	end
end



ENT.Type	    			= "ai"			--类
ENT.Base	    			= "base_ai"		--基础
ENT.PrintName				= "npccreate_jobnpc"		--名称
ENT.Category				= "nxrp" 		--类别名称
ENT.Author 					= "N/A"			--作者
ENT.Contact					= ""
ENT.Instructions			= "工作更换"		--介绍
ENT.Spawnable				= true			--可以生成
ENT.AdminSpawnable			= true			--管理员生成
ENT.AutomaticFrameAdvance	= true			--是否设置自动框架推进
