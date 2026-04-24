-- updated automatically
SEAS.G.lastHandScore = nil

-- hooks into trigger effect
local _trigger_effect = Card.trigger_effect
Card.trigger_effect = function(self, args)
    local nu_chips, nu_mult = _trigger_effect(self, args)
    if args and args.context == 'final_scoring_step' and args.chips and args.mult then
        -- nu vals are nil on anything that isnt plasma
        SEAS.G.lastHandScore = (nu_chips or args.chips) * (nu_mult or args.mult)
    end
    return nu_chips, nu_mult
end

-- returns score of last hand, or nil if it hadnt happened yet.
SEAS.FUNC.UTILS.getHandScore = function()
    if not G.GAME then return nil end
    return SEAS.G.lastHandScore
end
