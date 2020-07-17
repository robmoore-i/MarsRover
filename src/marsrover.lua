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
        length = length,
        objects = {}
    }
end

function addObjectToPlateau(plateau, object)
    plateau.objects[#plateau.objects + 1] = object
end

function simulatedRover(x, y, direction, remainingInstructions, plateau)
    local rover = {
        x = x,
        y = y,
        direction = direction,
        remainingInstructions = remainingInstructions,
        plateau = plateau,
        crashed = false
    }
    addObjectToPlateau(plateau, rover)
    return rover
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

function hasCollision(object1, object2)
    return object1.x == object2.x and object1.y == object2.y
end

function checkForCollisions(plateau)
    --noinspection UnassignedVariableAccess
    for index1, object1 in pairs(plateau.objects) do
        --noinspection UnassignedVariableAccess
        for index2, object2 in pairs(plateau.objects) do
            if not (object1 == object2) then
                if hasCollision(object1, object2) then
                    object1.crashed = true
                    object2.crashed = true
                end
            end
        end
    end
end

function moveForwards(simulatedRover)
    local components = movementComponents(simulatedRover)
    simulatedRover.y = simulatedRover.y + components.dy
    simulatedRover.x = simulatedRover.x + components.dx
    if outOfBounds(simulatedRover) then
        simulatedRover.crashed = true
    end
    checkForCollisions(simulatedRover.plateau)
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
    --noinspection UnassignedVariableAccess
    for index, rover in pairs(simulatedRovers) do
        if hasRemainingInstructions(rover) then
            return true
        end
    end
    return false
end

function simulateInstructions(simulatedRovers)
    --noinspection UnassignedVariableAccess
    for index, rover in pairs(simulatedRovers) do
        simulateNextInstruction(rover)
    end
end

function simulate(simulatedRovers)
    while anyRoversHaveRemainingInstructions(simulatedRovers) do
        simulateInstructions(simulatedRovers)
    end
    return simulatedRovers
end