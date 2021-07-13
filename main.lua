
-- Импорт библиотек и переменные
local GUI = require("GUI")
local system = require("System")
local fs = require("Filesystem")

local scrol = {}
local lines = {""}
local textzg = ""
local codeView = ""
local cvhei = 40
local cvwid = 48
local stran = 1
---------------------------------------------------------------------------------

-- Создание 2-х окошек
local workspace2, window2 = system.addWindow(GUI.filledWindow(65, 1, 50, 45, 0xCC9280))



-- Контейнеры. Разставление кнопок, полосок, ой короче всёй хуйни
local strelka1 = window2:addChild(GUI.layout(40, 2, 5, 3, 1, 1))
local strelka2 = window2:addChild(GUI.layout(45, 2, 5, 3, 1, 1))
local textnstrel = window2:addChild(GUI.layout(35, 1, 16, 3, 1, 1))
local inputloy = window2:addChild(GUI.layout(6, 2, 24, 3, 1, 1))
local loadbutton = window2:addChild(GUI.layout(24, 2, 24, 3, 1, 1))
local layout2 = window2:addChild(GUI.layout(1, 3, window2.width, window2.height, 1, 1))

-- Приведствие твоей папочки

-- Наименование строк

-- функции кнопочек и стрелочек

local function str1(textstr1)
return strelka1:addChild(GUI.roundedButton(1, 1, 3, 1, 0xD2D2D2, 0x696969, 0x4B4B4B, 0xF0F0F0, textstr1))
end

local function str2(textstr2)
return strelka2:addChild(GUI.roundedButton(1, 1, 3, 1, 0xD2D2D2, 0x696969, 0x4B4B4B, 0xF0F0F0, textstr2))
end

local function loadbut(textbutload)
return loadbutton:addChild(GUI.roundedButton(1, 1, 6, 1, 0xD2D2D2, 0x696969, 0x4B4B4B, 0xF0F0F0, textbutload))
end


local namefile = inputloy:addChild(GUI.input(15, 21, 24, 1, 0xEEEEEE, 0x555555, 0x999999, 0xFFFFFF, 0x2D2D2D, "MyBook", "Имя книги"))




-- номер страницы
local coustr = textnstrel:addChild(GUI.text(1, 1, 0x4B4B4B, "Cтраница: " .. stran))


local codeView = layout2:addChild(GUI.codeView(2, 2, 0, 0, 1, 1, 1, scrol, {}, GUI.LUA_SYNTAX_PATTERNS, GUI.LUA_SYNTAX_COLOR_SCHEME, true, lines))


-- стрелочки
str1("<").onTouch = function()
  if stran < 2 then
    GUI.alert("Дурень, страницы ниже первой не существует. Ты понял меня?")
  else
    stran = stran - 1
    coustr:remove()
    local coustr = textnstrel:addChild(GUI.text(1, 1, 0x4B4B4B, "Cтраница: " .. stran))
    codeView:remove()
    local codeView = layout2:addChild(GUI.codeView(2, 2, cvwid, cvhei, 1, 1, 1, scrol, {}, GUI.LUA_SYNTAX_PATTERNS, GUI.LUA_SYNTAX_COLOR_SCHEME, true, {}))
    local counter = 4
    for line in require("filesystem").lines("/Books/" .. namefile.text .. ".app/" .. stran .. ".txt") do
      line = line:gsub("\t", "  "):gsub("\r\n", "\n")
      codeView.maximumLineLength = math.max(4, unicode.len(line)) --codeView.maximumLineLength, unicode.len(line))
      table.insert(codeView.lines, line) -- codeView.lines,

      counter = counter + 1
      if counter > codeView.height then
        break
      end
    end
  end
end
str2(">").onTouch = function()
  stran = stran + 1
  fs.append("/Books/" .. namefile.text .. ".app/" .. stran .. ".txt", "")
  coustr:remove()
  local coustr = textnstrel:addChild(GUI.text(1, 1, 0x4B4B4B, "Cтраница: " .. stran))
  codeView:remove()
    local codeView = layout2:addChild(GUI.codeView(2, 2, cvwid, cvhei, 1, 1, 1, scrol, {}, GUI.LUA_SYNTAX_PATTERNS, GUI.LUA_SYNTAX_COLOR_SCHEME, true, {}))
    local counter = 4
    for line in require("filesystem").lines("/Books/" .. namefile.text .. ".app/" .. stran .. ".txt") do
      line = line:gsub("\t", "  "):gsub("\r\n", "\n")
      codeView.maximumLineLength = math.max(4, unicode.len(line)) --codeView.maximumLineLength, unicode.len(line))
      table.insert(codeView.lines, line) -- codeView.lines,

      counter = counter + 1
      if counter > codeView.height then
        break
      end
    end
  if stran > 127 then
    stran = stran - 1
    GUI.alert("Упс.. больше 128 страницы нету :()")
  else
  --fs.append("/notepad/" .. namefile.text, " " .. lable.text)
  end
end
loadbut("Load").onTouch = function()
  codeView:remove()
  local codeView = layout2:addChild(GUI.codeView(2, 2, cvwid, cvhei, 1, 1, 1, scrol, {}, GUI.LUA_SYNTAX_PATTERNS, GUI.LUA_SYNTAX_COLOR_SCHEME, true, {}))
  local counter = 4
  for line in require("filesystem").lines("/Books/" .. namefile.text .. ".app/" .. stran .. ".txt") do
    line = line:gsub("\t", "  "):gsub("\r\n", "\n")
    codeView.maximumLineLength = math.max(4, unicode.len(line)) --codeView.maximumLineLength, unicode.len(line))
    table.insert(codeView.lines, line) -- codeView.lines,

    counter = counter + 1
    if counter > codeView.height then
      break
    end
  end
end




-- Окошко, где будет отображатся текст

-- действия кнопок и прочей хуйни которая меня не ебёт


-- Верхнее управление окном

-- Чё-то Игор Темофеев писал за хуйню тут.

window2.onResize = function(newWidth, newHeight)
  window2.backgroundPanel.width, window2.backgroundPanel.height = newWidth, newHeight
  layout.width, layout.height = newWidth, newHeight
end

---------------------------------------------------------------------------------

-- И дураку понятно что тут.
workspace2:draw()
