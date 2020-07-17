--noinspection UnassignedVariableAccess
luaunit = require('luaunit')
--noinspection UnassignedVariableAccess
require('src/marsrover')
--noinspection UnassignedVariableAccess
tablex = require('pl.tablex')

function testMovingNorth()
    local simulatedRovers = simulate(plateau(5, 5), simulatedRover(1, 2, "N", "M"))
    luaunit.assertEquals(tablex.size(simulatedRovers), 1)
    local firstRover = simulatedRovers[1]
    luaunit.assertEquals(firstRover.x, 1)
    luaunit.assertEquals(firstRover.y, 3)
    luaunit.assertEquals(firstRover.direction, "N")
    luaunit.assertEquals(firstRover.remainingInstructions, "")
end

function testTurning()
    local simulatedRovers = simulate(plateau(5, 5), simulatedRover(1, 2, "N", "ML"))
    luaunit.assertEquals(tablex.size(simulatedRovers), 1)
    local firstRover = simulatedRovers[1]
    luaunit.assertEquals(firstRover.x, 1)
    luaunit.assertEquals(firstRover.y, 3)
    luaunit.assertEquals(firstRover.direction, "W")
    luaunit.assertEquals(firstRover.remainingInstructions, "")
end

os.exit(luaunit.LuaUnit.run())

