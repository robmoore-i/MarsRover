--noinspection UnassignedVariableAccess
luaunit = require('luaunit')
--noinspection UnassignedVariableAccess
require('src/marsrover')
--noinspection UnassignedVariableAccess
tablex = require('pl.tablex')

function testFirstExampleRover()
    local simulatedRovers = simulate(plateau(5, 5), {simulatedRover(1, 2, "N", "LMLMLMLMM")})
    luaunit.assertEquals(tablex.size(simulatedRovers), 1)
    local firstRover = simulatedRovers[1]
    luaunit.assertEquals(firstRover.x, 1)
    luaunit.assertEquals(firstRover.y, 3)
    luaunit.assertEquals(firstRover.direction, "N")
    luaunit.assertEquals(firstRover.remainingInstructions, "")
end

function testSecondExampleRover()
    local simulatedRovers = simulate(plateau(5, 5), {simulatedRover(3, 3, "E", "MMRMMRMRRM")})
    luaunit.assertEquals(tablex.size(simulatedRovers), 1)
    local firstRover = simulatedRovers[1]
    luaunit.assertEquals(firstRover.x, 5)
    luaunit.assertEquals(firstRover.y, 1)
    luaunit.assertEquals(firstRover.direction, "E")
    luaunit.assertEquals(firstRover.remainingInstructions, "")
end

function testTurningLeft()
    local rover = simulatedRover(1, 2, "N", "LLLL")
    simulateNextInstruction(rover)
    luaunit.assertEquals(rover.direction, "W")
    simulateNextInstruction(rover)
    luaunit.assertEquals(rover.direction, "S")
    simulateNextInstruction(rover)
    luaunit.assertEquals(rover.direction, "E")
    simulateNextInstruction(rover)
    luaunit.assertEquals(rover.direction, "N")
end

function testTurningRight()
    local rover = simulatedRover(1, 2, "N", "RRRR")
    simulateNextInstruction(rover)
    luaunit.assertEquals(rover.direction, "E")
    simulateNextInstruction(rover)
    luaunit.assertEquals(rover.direction, "S")
    simulateNextInstruction(rover)
    luaunit.assertEquals(rover.direction, "W")
    simulateNextInstruction(rover)
    luaunit.assertEquals(rover.direction, "N")
end

function testMovingNorth()
    local rover = simulatedRover(1, 2, "N", "M")
    simulateNextInstruction(rover)
    luaunit.assertEquals(rover.x, 1)
    luaunit.assertEquals(rover.y, 3)
    luaunit.assertEquals(rover.direction, "N")
end

function testMovingSouth()
    local rover = simulatedRover(1, 3, "S", "M")
    simulateNextInstruction(rover)
    luaunit.assertEquals(rover.x, 1)
    luaunit.assertEquals(rover.y, 2)
    luaunit.assertEquals(rover.direction, "S")
end

function testMovingWest()
    local rover = simulatedRover(5, 3, "W", "M")
    simulateNextInstruction(rover)
    luaunit.assertEquals(rover.x, 4)
    luaunit.assertEquals(rover.y, 3)
    luaunit.assertEquals(rover.direction, "W")
end

function testMovingEast()
    local rover = simulatedRover(5, 3, "E", "M")
    simulateNextInstruction(rover)
    luaunit.assertEquals(rover.x, 6)
    luaunit.assertEquals(rover.y, 3)
    luaunit.assertEquals(rover.direction, "E")
end

function testDoesNothingIfNoMoreInput()
    local rover = simulatedRover(2, 4, "E", "")
    simulateNextInstruction(rover)
    simulateNextInstruction(rover)
    simulateNextInstruction(rover)
    luaunit.assertEquals(rover.x, 2)
    luaunit.assertEquals(rover.y, 4)
    luaunit.assertEquals(rover.direction, "E")
end

os.exit(luaunit.LuaUnit.run())

