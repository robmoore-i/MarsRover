--
--
-- Program: Input -> (RemainingInput, Rovers) -> (RemainingInput, Rovers) -> ... until RemainingInput is empty
--
--

--noinspection UnassignedVariableAccess
tablex = require('pl.tablex')

function plateau(width, length)
    return {
        width = width,
        length = length
    }
end

function simulatedRover(x, y, direction, remainingInstructions, plateau)
    return {
        x = x,
        y = y,
        direction = direction,
        remainingInstructions = remainingInstructions,
        plateau = plateau,
        crashed = false
    }
end

function beheadString(s)
    return string.sub(s, 2, string.len(s))
end

function nextInstruction(simulatedRover)
    return string.sub(simulatedRover.remainingInstructions, 0, 1)
end

function turnLeft(simulatedRover)
    local leftTurns = {
        ["N"] = "W",
        ["S"] = "E",
        ["E"] = "N",
        ["W"] = "S"
    }
    simulatedRover.direction = leftTurns[simulatedRover.direction]
end

function turnRight(simulatedRover)
    local rightTurns = {
        ["N"] = "E",
        ["S"] = "W",
        ["E"] = "S",
        ["W"] = "N"
    }
    simulatedRover.direction = rightTurns[simulatedRover.direction]
end

function movementComponents(simulatedRover)
    local dxComponents = {
        ["N"] = 0,
        ["S"] = 0,
        ["E"] = 1,
        ["W"] = -1
    }
    local dyComponents = {
        ["N"] = 1,
        ["S"] = -1,
        ["E"] = 0,
        ["W"] = 0
    }
    return {
        dx = dxComponents[simulatedRover.direction],
        dy = dyComponents[simulatedRover.direction]
    }
end

function outOfBounds(simulatedRover)
    return simulatedRover.x > simulatedRover.plateau.width or simulatedRover.y > simulatedRover.plateau.length
end

function moveForwards(simulatedRover)
    local components = movementComponents(simulatedRover)
    simulatedRover.y = simulatedRover.y + components.dy
    simulatedRover.x = simulatedRover.x + components.dx
    if outOfBounds(simulatedRover) then
        simulatedRover.crashed = true
    end
end

function simulateNextInstruction(simulatedRover)
    if simulatedRover.remainingInstructions == "" or simulatedRover.crashed then
        return
    end
    if nextInstruction(simulatedRover) == "M" then
        moveForwards(simulatedRover)
    elseif nextInstruction(simulatedRover) == "L" then
        turnLeft(simulatedRover)
    elseif nextInstruction(simulatedRover) == "R" then
        turnRight(simulatedRover)
    end
    simulatedRover.remainingInstructions = beheadString(simulatedRover.remainingInstructions)
end

function hasRemainingInstructions(simulatedRover)
    return not (simulatedRover.remainingInstructions == "")
end

function anyRoversHaveRemainingInstructions(simulatedRovers)
    for k, v in pairs(simulatedRovers) do
        print(k)
    end
end

function simulate(simulatedRovers)
    while hasRemainingInstructions(simulatedRovers[1]) do
        anyRoversHaveRemainingInstructions(simulatedRovers)
        simulateNextInstruction(simulatedRovers[1])
    end
    return { simulatedRovers[1] }
end