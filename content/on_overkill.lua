local calc_ref = Card.calculate_joker

function Card.calculate_joker(self, context)
    if context.main_scoring then
        local hand_val = SEAS.FUNC.UTILS.getHandScore()
        local total_chips_with_hand = G.GAME.chips + hand_val
        local target = G.GAME.blind.chips


        context.overkill = {
            amount = total_chips_with_hand / math.max(1, target), -- How many times was the req broken
            bleed = math.max(0, total_chips_with_hand - target),  -- The overflow
            is_overkill = total_chips_with_hand >= target         -- Did it happen in the first place?
        }
    end


    return calc_ref(self, context)
end
