local Window = require 'lib.window'
local Font = require 'lib.font'

local controls_window = {}
controls_window.__index = controls_window

controls_window.width = 30
controls_window.height = 20

controls_window.font_width = 7
controls_window.font_height = 14
controls_window.font_glyphs = {
    "ABCDEFGHIJK",
    "LMNOPQRSTUV",
    "WXYZ 123456",
    "7890abcdefg",
    "hijklmnopqr",
    "stuvwxyz!?\"",
    "'.,:;-_()/\\",
    "|[]<>~=+#^%",
    "*┌┐└┘─│╭╮╰╯",
    "├┤╟╢",
}
controls_window.font = Font.new("res/font_1.png", 
                                controls_window.font_width, 
                                controls_window.font_height, 
                                controls_window.font_glyphs)

controls_window.foreground_colour = {0.6, 0.6, 0.6}

function controls_window.new()
    local self = {}
    setmetatable(self, controls_window)

    self.window = Window.new(controls_window.width, controls_window.height, controls_window.font, controls_window.foreground_colour)
    self.window.tile_width = controls_window.font_width
    self.window.tile_height = controls_window.font_height

    for i = 2, controls_window.width - 1 do
        self.window:write("─", i, 1)
        self.window:write("─", i, controls_window.height)
    end
    for i = 2, controls_window.height - 1 do
        self.window:write("│", 1, i)
        self.window:write("│", controls_window.width, i)
    end
    self.window:write("┌─╢╟", 1, 1)
    self.window:write("┐", controls_window.width, 1)
    self.window:write("└", 1, controls_window.height)
    self.window:write("┘", controls_window.width, controls_window.height)

    self.window:refresh()

    return self
end

function controls_window:draw()
    local x = -controls_window.font_width * controls_window.width
    local y = -controls_window.font_height * controls_window.height
    self.window:draw(x, y)
end

return controls_window
