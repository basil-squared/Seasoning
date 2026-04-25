function SEAS.FUNC.getKeyForValue(t, value)
    for k, v in pairs(t) do
        if v == value then
            return k
        end
    end
    return nil
end
