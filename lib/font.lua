local utf8 = require "utf8"

local font = {}
font.__index = font

function font.new(image_file, width, height, glyph_table)
    local self = {}
    setmetatable(self, font)
    self.image = love.graphics.newImage(image_file)
    local image_width = self.image:getWidth()
    local image_height = self.image:getHeight()
    self.glyph_lookup = {}
    for j, row in pairs(glyph_table) do
        local i = 1
        for _, code in utf8.codes(row) do
            local char = utf8.char(code)
            local x = (i - 1) * width
            local y = (j - 1) * height
            self.glyph_lookup[char] = love.graphics.newQuad(x, y, width, height, image_width, image_height)
            i = i + 1
        end
    end
    self.width = width
    self.height = height
    return self
end

function font:print(char, x, y)
    local quad = self.glyph_lookup[char]
    if not quad then
        error("Missing the character '" .. char .. "'.")
    end
    love.graphics.draw(self.image, quad, x, y)
end

return font
