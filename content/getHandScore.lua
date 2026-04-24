-- Shorthand to grab hand score that also nil checks
SEAS.FUNC.UTILS.getHandScore = function()
    if not G.GAME then return end
    if hand_chips and mult then
        return hand_chips * mult
    else
        return nil
    end
end
