local lines = {}

--#region UI

local tab = Menu.Create("General", "LUA", "Lines")
tab:Icon("\u{f06e}") -- глазик))
local group = tab:Create("Main"):Create("Lines Example Script")

local ui = {}

ui.global_switch = group:Switch("Включить линии", false, "\u{f00c}")
ui.line_width = group:Slider("Толщина линии", 1, 10, 1)
ui.line_width:Icon("\u{f040}")
ui.gradient_color1 = group:ColorPicker("Цвет 1", Color(255, 0, 0), "\u{f53f}")
ui.gradient_color2 = group:ColorPicker("Цвет 2", Color(0, 0, 255), "\u{f53f}")
ui.gradient_color3 = group:ColorPicker("Цвет 3", Color(0, 255, 0), "\u{f53f}")
ui.gradient_color4 = group:ColorPicker("Цвет 4", Color(255, 255, 0), "\u{f53f}")
ui.gradient_color5 = group:ColorPicker("Цвет 5", Color(255, 0, 255), "\u{f53f}")

ui.gradient_enabled = group:Switch("Градиент", false, "\u{f302}")
ui.gradient_smoothness = group:Slider("Сглаживание линии", 1, 100, 10)

ui.global_switch:SetCallback(function()
  ui.line_width:Disabled(not ui.global_switch:Get())
  ui.gradient_color1:Disabled(not ui.global_switch:Get() or not ui.gradient_enabled:Get())
  ui.gradient_color2:Disabled(not ui.global_switch:Get() or not ui.gradient_enabled:Get())
  ui.gradient_color3:Disabled(not ui.global_switch:Get() or not ui.gradient_enabled:Get())
  ui.gradient_color4:Disabled(not ui.global_switch:Get() or not ui.gradient_enabled:Get())
  ui.gradient_color5:Disabled(not ui.global_switch:Get() or not ui.gradient_enabled:Get())
  ui.gradient_enabled:Disabled(not ui.global_switch:Get())
  ui.gradient_smoothness:Disabled(not ui.global_switch:Get())
end, true)

ui.gradient_enabled:SetCallback(function()
  ui.gradient_color1:Disabled(not ui.gradient_enabled:Get())
  ui.gradient_color2:Disabled(not ui.gradient_enabled:Get())
  ui.gradient_color3:Disabled(not ui.gradient_enabled:Get())
  ui.gradient_color4:Disabled(not ui.gradient_enabled:Get())
  ui.gradient_color5:Disabled(not ui.gradient_enabled:Get())
end)

--#endregion UI

--#region Functions

local function DrawLines()
  if not ui.global_switch:Get() then return end

  local myHero = Heroes.GetLocal()
  if not myHero then return end

  local myPos = Entity.GetAbsOrigin(myHero)
  local myPosScreen = Render.WorldToScreen(myPos)

  local screenSize = Render.ScreenSize()

  for i = 1, Heroes.Count() do
    local hero = Heroes.Get(i)
    if hero and hero ~= myHero and not Entity.IsSameTeam(myHero, hero) and Entity.IsAlive(hero) then
      local heroPos = Entity.GetAbsOrigin(hero)
      local heroPosScreen = Render.WorldToScreen(heroPos)
      local width = ui.line_width:Get()
      if
        myPosScreen.x > 0 and myPosScreen.x < screenSize.x and
        myPosScreen.y > 0 and myPosScreen.y < screenSize.y and
        heroPosScreen.x > 0 and heroPosScreen.x < screenSize.x and
        heroPosScreen.y > 0 and heroPosScreen.y < screenSize.y
      then
        if ui.gradient_enabled:Get() then
          local dx = heroPosScreen.x - myPosScreen.x
          local dy = heroPosScreen.y - myPosScreen.y
          local distance = math.sqrt(dx * dx + dy * dy)
          local numSegments = ui.gradient_smoothness:Get()
          local dirX = dx / distance
          local dirY = dy / distance

          local points = {}
          for j = 0, numSegments do
            local t = j / numSegments
            local x = myPosScreen.x + dirX * (t * distance)
            local y = myPosScreen.y + dirY * (t * distance)
            table.insert(points, Vec2(x, y))
          end

          local colors = {
            ui.gradient_color1:Get(),
            ui.gradient_color2:Get(),
            ui.gradient_color3:Get(),
            ui.gradient_color4:Get(),
            ui.gradient_color5:Get()
          }

          for j = 1, #points - 1 do
            local t = (j - 1) / (#points - 2)
            local colorIndex = math.floor(t * (#colors - 1)) + 1
            local nextColorIndex = colorIndex + 1
            if nextColorIndex > #colors then nextColorIndex = 1 end
            local tColor = (t * (#colors - 1)) - (colorIndex - 1)

            local color1 = colors[colorIndex]
            local color2 = colors[nextColorIndex]

            local color = Color(
              (1 - tColor) * color1.r + tColor * color2.r,
              (1 - tColor) * color1.g + tColor * color2.g,
              (1 - tColor) * color1.b + tColor * color2.b,
              (1 - tColor) * color1.a + tColor * color2.a
            )
            Render.Line(points[j], points[j + 1], color, width)
          end
        else

          local color = ui.gradient_color1:Get()
          Render.Line(myPosScreen, heroPosScreen, color, width)
        end
      end
    end
  end
end

--#endregion Functions

--#region Callbacks

lines.OnDraw = function()
  DrawLines()
end

--#endregion Callbacks

return lines