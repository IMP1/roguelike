local WindowControls = require 'res.window_controls'
local WindowInput = require 'res.window_input'

local windows = {}

function love.load()
    windows.controls = WindowControls.new()
    windows.input = WindowInput.new()
end

function love.keypressed(key)
    if key == "q" and love.keyboard.isDown("lctrl", "rctrl") then
        love.event.quit()
    end
    -- TODO: If input window is active
    windows.input:keypressed(key)
end

function love.textinput(text)
    -- TODO: If input window is active
    windows.input:keytyped(text)
end

function love.update(dt)
end

function love.draw()
    -- windows.controls:draw()
    windows.input:draw()
end
