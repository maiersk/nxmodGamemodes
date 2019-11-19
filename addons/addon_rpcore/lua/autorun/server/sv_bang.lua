--帮派 服务器端

local bang = {}
bang.needlevel = 20
bang.needmoney = 1000
bang.needjob = "citizen"

--创建帮派
 --有等级限制, 并花费money, 可选: 创建多少人的帮派
function bang.create(ply, bangname)

    --判断玩家职业
    local job = ply:GetUserGroup()
    if job ~= bang.needjob then 
        ply:PrintMessage(HUD_PRINTTALK, "只有成为"..bang.needjob.."职业才可以创建黑帮!")
        return
    end 

    --判断玩家等级
    local level = ply:GetNWInt("Level" .. "_" .. job) or 0      --是Level还是level?
    if level < bang.needlevel then      --小于20级无法创建帮派
        ply:PrintMessage(HUD_PRINTTALK, "小于"..bang.needlevel.."级无法创建黑帮!")
        return 
    end 

    --扣除玩家money
    if !ply:money_take(bang.needmoney) then 
        ply:PrintMessage(HUD_PRINTTALK, "金钱不足"..bang.needmoney.."$.无法创建黑帮!")
        return
    end 

    --创建帮派
    local name = bangname or (ply:GetName().."的黑帮")

end 

--解散帮派
function bang.jiesan()

end 

--将某人移出帮派
function bang.yichu()


end 

--申请加入帮派
function bang.shenqing()

end 

--退出帮派
function bang.quit()

end

--邀请某人加入帮派
function bang.yaoqing()

end

--任命某人职务
function bang.renming()

end

--辞职
function bang.cizhi()

end

--发起任务
function bang.renwu()

end 

--占领地盘
function bang.zhanling()

end


return bang