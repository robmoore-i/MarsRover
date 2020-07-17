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

function simulateNextInstruction(simulatedRover)
    if nextInstruction(simulatedRover) == "M" then
        simulatedRover.y = simulatedRover.y + 1
    elseif nextInstruction(simulatedRover) == "L" then
        simulatedRover.direction = "W"
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