local utf8 = require "utf8"

local window = {}
window.__index = window

local DEFAULT_BACKGROUND_COLOUR = {0, 0, 0}
local DEFAULT_FOREGROUND_COLOUR = {1, 1, 1}
local DEFAULT_TILE_PIXEL_WIDTH = 14
local DEFAULT_TILE_PIXEL_HEIGHT = 14

function window.new(width, height, font, fg_colour, bg_colour)
    local self = {}
    setmetatable(self, window)

    self.width = width
    self.height = height
    self.font = font
    self.tile_width = DEFAULT_TILE_PIXEL_WIDTH
    self.tile_height = DEFAULT_TILE_PIXEL_HEIGHT
    self.default_foreground_colour = fg_colour or DEFAULT_FOREGROUND_COLOUR
    self.default_background_colour = bg_colour or DEFAULT_BACKGROUND_COLOUR
    self.canvas = love.graphics.newCanvas(self.width * self.tile_width, self.height * self.tile_height)
    
    self.tiles = {}
    for j = 1, self.height do
        self.tiles[j] = {}
        for i = 1, self.width do
            self.tiles[j][i] = { 
                glyph = " ", 
                background = self.default_background_colour,
                foreground = self.default_foreground_colour,
            }
        end
    end
    self:refresh()

    return self
end

local function print_char(self, char, x, y)
    if self.font then
        self.font:print(char, x, y)
    else
        love.graphics.print(char, x, y)
    end
end

function window:refresh()
    love.graphics.setCanvas(self.canvas)
    love.graphics.clear()
    local w = self.tile_width
    local h = self.tile_height
    for j, row in pairs(self.tiles) do
        for i, tile in pairs(row) do
            local x = (i - 1) * w
            local y = (j - 1) * h
            love.graphics.setColor(tile.background)
            love.graphics.rectangle("fill", x, y, w, h)
            love.graphics.setColor(tile.foreground)
            print_char(self, tile.glyph, x, y)
        end
    end
    love.graphics.setCanvas()
end

function window:set_char(char, x, y)
    local tile = self.tiles[y][x]
    if tile then
        tile.glyph = char
    end
end

function window:set_foreground(colour, x, y)
    local tile = self.tiles[y][x]
    if tile then
        tile.foreground = colour
    end
end

function window:set_background(colour, x, y)
    local tile = self.tiles[y][x]
    if tile then
        tile.background = colour
    end
end

function window:write(text, x, y)
    local i = 1
    for _, code in utf8.codes(text) do
        local char = utf8.char(code)
        self:set_char(char, x + i - 1, y)
        i = i + 1
    end
    self:refresh()
end

function window:clear(x, y)
    self:set_char(" ", x, y)
end

function window:draw(x, y)
    x = x % love.graphics.getWidth()
    y = y % love.graphics.getHeight()
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(self.canvas, x, y)
end

return window
