local Window = require 'lib.window'
local Font = require 'lib.font'

local input_window = {}
input_window.__index = input_window

input_window.width = 48
input_window.height = 12

input_window.font_width = 7
input_window.font_height = 14
input_window.font_glyphs = {
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
input_window.font = Font.new("res/font_1.png", 
                             input_window.font_width, 
                             input_window.font_height, 
                             input_window.font_glyphs)

input_window.command_colour = {0.3, 0.5, 0.8}
input_window.suggestion_colour = {0.2, 0.4, 0.5}
input_window.border_colour = {0.6, 0.6, 0.6}

function input_window.new()
    local self = {}
    setmetatable(self, input_window)

    self.window = Window.new(input_window.width, input_window.height, input_window.font, input_window.border_colour)
    self.window.tile_width = input_window.font_width
    self.window.tile_height = input_window.font_height

    for i = 2, input_window.width - 1 do
        self.window:write("─", i, 1)
        self.window:write("─", i, input_window.height)
        self.window:write("─", i, input_window.height - 2)
        self.window:set_foreground(input_window.command_colour, i, input_window.height - 1)
    end
    for i = 2, input_window.height - 1 do
        self.window:write("│", 1, i)
        self.window:write("│", input_window.width, i)
    end
    self.window:write("┌─╢ L O G ╟", 1, 1)
    self.window:write("┐", input_window.width, 1)
    self.window:write("└", 1, input_window.height)
    self.window:write("┘", input_window.width, input_window.height)
    self.window:write("├", 1, input_window.height - 2)
    self.window:write("┤", input_window.width, input_window.height - 2)

    self.window:refresh()

    self.command_history = {}
    self.current_command = ""
    self.current_autocompletions = {}
    self.current_autocompletion_index = 0

    return self
end

function input_window:keypressed(key)
    if key == "backspace" then

    elseif key == "return" or key == "enter" then

    elseif key == "tab" then
        if love.keyboard.isDown("lshift", "rshift") then
            self.current_autocompletion_index = self.current_autocompletion_index - 1
            if self.current_autocompletion_index < 0 then
                self.current_autocompletion_index = #self.current_autocompletions
            end
        else
            self.current_autocompletion_index = self.current_autocompletion_index + 1
            if self.current_autocompletion_index > #self.current_autocompletions then
                self.current_autocompletion_index = 0
            end
        end
    else
    end
    self:refresh_current_command()
end

function input_window:keytyped(text)
    self.current_command = self.current_command .. text
    self:refresh_current_command()
end

function input_window:refresh_current_command()
    self.current_autocompletions = {"Say", "Ask", "Move"}
    -- TODO: Find useful autocompletion suggestions
    -- TODO: Order suggestions by relevance somehow
    for i = 2, input_window.width - 1 do
        self.window:clear(i, input_window.height - 1)
        self.window:set_foreground(input_window.suggestion_colour, i, input_window.height - 1)
    end
    local suggestion = self.current_autocompletions[self.current_autocompletion_index]
    if suggestion then
        self.window:write(suggestion, 2, input_window.height - 1)
    end

    for i = 2, 1 + #self.current_command do
        self.window:set_foreground(input_window.command_colour, i, input_window.height - 1)
    end
    self.window:write(self.current_command, 2, input_window.height - 1)
end

function input_window:draw()
    local x = -input_window.font_width * input_window.width
    local y = -input_window.font_height * input_window.height
    self.window:draw(x, y)
end

return input_window
