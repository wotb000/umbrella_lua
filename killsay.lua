local minaev = {
    "эм чё мелонити не запредиктил выход моего члена те на рот падла",
    "не ори тварь, у тебя читуха не может в паблик релиз выйти даже",
    "чмошник опять был заовнен. refund melonity",
    "сегодня устраиваю скриптовую битву моего хуя и твоего ротана уёбак",
    "промик на мелонити в2: TblgoJL6ae6",
    "Get Good. Get UC.Zone",
    "заовнен чушка ебанутая",
    "не успел меня увидеть из-за оптимизации мелонити?",
    "поори тварь что ты юзаешь мелонити",
    "от 0 до 60 фпс оптимизации by стас минаев"
}
local engtoxic = {
    "I'd tell you to shoot yourself, but I bet your miss",
	"You should let your chair play, at least it knows how to support.",
	"The only thing lower than your k/d ratio is your I.Q.",
	"Did you know sharks only kill 5 people each year? Looks like you got some competition",
    "Some babies were dropped on their heads but you were clearly thrown at a wall",
	"Internet Explorer is faster than your reactions.",
	"I'm surprised you've got the brain power to keep your heart beating",
	"You're about as useful as pedals on a wheelchair.",
	"You define autism",
	"The only thing you carry is an extra chromosome.",
    "Choose your excuse: 1.Lags | 2.New mouse | 3.Low FPS | 4.Low team | 5.Hacker | 6.Lucker | 7.Smurf | 8.Hitbox | 9.Tickrate",
    "I'm not trash talking, I'm talking to trash.",
    "You don't deserve to play this game. Go back to playing with crayons and shitting yourself",
    "Your family tree must be a circle.",
    "Is your monitor on?",
	"Don't be a loser, buy a rope and hang yourself.",
	"If I were to commit suicide, I would jump from your ego to your MMR.",
	"Do you feel special? Please try suicide again... Hopefully you will be successful this time.",
	"Sell your computer and buy a Wii.",
    "Your brain activity is so poor that people held a fundraiser for it",
    "Better buy PC, stop playing at school library",
    "The only thing more unreliable than you is the condom your dad used.",
    "Calling you a retard is a compliment in comparison to how stupid you actually are.",
    "uc.zone - just the best",
    "uc.zone - better than luck",
    "uc.zone - dont be owned anymore",
    "uc.zone - die or buy",
    "uc.zone - best features without lack of security."
}

local ui = {}
local killsay = {}
local tab = Menu.Create("General", "Main", "лучшая луашка") tab:Icon("\u{f6b6}")
tab:Icon("\u{f6b6}")
local TrashtalkG = tab:Create("Main"):Create("Trashtalk")

ui.global_switch = TrashtalkG:Switch("Enable", false, "\u{f00c}")
ui.trashtalk = TrashtalkG:Switch("TrashTalk", false, "\u{f619}")
ui.trashtalkS = TrashtalkG:MultiCombo("Type", {"Мелонити юзеры", "Пендосам"}, {})
ui.trashtalkTeam = TrashtalkG:Switch("In teamchat", false, "\u{f63d}")
ui.trashtalkbind = TrashtalkG:Bind("Bind", Enum.ButtonCode.KEY_NONE, "\u{e1c0}")

local MMapG = tab:Create("Main"):Create("MiniMap things...")
ui.minimapdrawer = MMapG:Switch("MiniMap Drawer (indev)", false, "\u{e024}")

ui.global_switch:SetCallback(function ()
    ui.trashtalk:Disabled(not ui.global_switch:Get())
    ui.trashtalkS:Disabled(not ui.global_switch:Get())
    ui.trashtalkTeam:Disabled(not ui.global_switch:Get())
    ui.trashtalkbind:Disabled(not ui.global_switch:Get())
    ui.minimapdrawer:Disabled(not ui.global_switch:Get())
end, true)

local function trashtalk()
    if not ui.trashtalk:Get() then return end
    
    local isSenSelected = ui.trashtalkS:Get("Мелонити юзеры")
    local isSentestSelected = ui.trashtalkS:Get("Пендосам")
    
    local chatList = {}
    
    if isSenSelected then 
        for _, v in ipairs(minaev) do
            table.insert(chatList, v)
        end
    end
    
    if isSentestSelected then 
        for _, v in ipairs(engtoxic) do
            table.insert(chatList, v)
        end
    end
    
    if #chatList == 0 then return end
    
    local chatmsgindex = math.random(0, #chatList)
    local chatmsg = chatList[chatmsgindex]
    
    if ui.trashtalkbind:IsPressed() then
        if ui.trashtalkTeam:Get() then
            return { Engine.ExecuteCommand("say_team \"" .. chatmsg .. "\"") }
        else
            return { Engine.ExecuteCommand("say \"" .. chatmsg .. "\"") }
        end
    end
end

killsay.OnUpdate = function ()

    if not ui.global_switch:Get() then
        return
    end

    if trashtalk() then return end
end

return killsay