local sen = {
    [1] = "Категория Sen, фраза 1",
    [2] = "Категория Sen, фраза 2",
    [3] = "Категория Sen, фраза 3",
}
local sentest = {
    [1] = "Категория SenTest, фраза 1",
    [2] = "Категория SenTest, фраза 2",
    [3] = "Категория SenTest, фраза 3",
}

local ui = {}
local killsay = {}
local tab = Menu.Create("General", "Main", "Nigga.lua") tab:Icon("\u{f6b6}")
tab:Icon("\u{f6b6}")
local TrashtalkG = tab:Create("Main"):Create("Trashtalk")

ui.global_switch = TrashtalkG:Switch("Enable", false, "\u{f00c}")
ui.trashtalk = TrashtalkG:Switch("TrashTalk", false, "\u{f619}")
ui.trashtalkS = TrashtalkG:MultiCombo("Type", {"sen", "sentest"}, {})
ui.trashtalkbind = TrashtalkG:Bind("TrashTalk bind", Enum.ButtonCode.KEY_NONE, "\u{e1c0}")

local MMapG = tab:Create("Main"):Create("MiniMap things...")
ui.minimapdrawer = MMapG:Switch("MiniMap Drawer (indev)", false, "\u{e024}")

ui.global_switch:SetCallback(function ()
    ui.trashtalk:Disabled(not ui.global_switch:Get())
    ui.trashtalkS:Disabled(not ui.global_switch:Get())
    ui.trashtalkbind:Disabled(not ui.global_switch:Get())
    ui.minimapdrawer:Disabled(not ui.global_switch:Get())
end, true)

local function trashtalk(entity)
    if not ui.trashtalk:Get() then return end
    
    local isSenSelected = ui.trashtalkS:Get("sen")
    local isSentestSelected = ui.trashtalkS:Get("sentest")
    
    local chatList = {}
    
    if isSenSelected then 
        for _, v in ipairs(sen) do
            table.insert(chatList, v)
        end
    end
    
    if isSentestSelected then 
        for _, v in ipairs(sentest) do
            table.insert(chatList, v)
        end
    end
    
    if #chatList == 0 then return end
    
    local chatmsgindex = math.random(1, #chatList)
    local chatmsg = chatList[chatmsgindex]
    
    if ui.trashtalkbind:IsPressed() then
        return { Engine.ExecuteCommand("say \"" .. chatmsg .. "\"") }
    end
end

killsay.OnUpdate = function ()

    if not ui.global_switch:Get() then
        return
    end

    if trashtalk() then return end
end

return killsay