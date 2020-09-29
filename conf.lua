function love.conf(game)
    game.window.title = "Roguelike"
    game.window.width = 14 * 80
    game.window.height = 14 * 50

    game.modules.data = false
    game.modules.joystick = false
    game.modules.math = false
    game.modules.physics = false
    game.modules.system = false
    game.modules.touch = false
    game.modules.video = false
end
