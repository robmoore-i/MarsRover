--
--
-- Program: Input -> (RemainingInput, Rovers) -> (RemainingInput, Rovers) -> ... until RemainingInput is empty
--
--

--noinspection UnassignedVariableAccess
tablex = require('pl.tablex')

function plateau(width, length)
end

function simulatedRover(x, y, direction, remainingInstructions)
    return {
        x = x,
        y = y,
        direction = direction,
        remainingInstructions = remainingInstructions
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

function simulateNextInstruction(simulatedRover)
    if nextInstruction(simulatedRover) == "M" then
        local components = movementComponents(simulatedRover)
        simulatedRover.y = simulatedRover.y + components.dy
        simulatedRover.x = simulatedRover.x + components.dx
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

function simulate(plateau, simulatedRover)
    while hasRemainingInstructions(simulatedRover) do
        simulateNextInstruction(simulatedRover)
    end
    return { simulatedRover }
end