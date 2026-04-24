SEAS.FUNC.UTILS.tableContains = function(t, val)
    for k, v in pairs(t) do
        if v == val then
            return true -- just stop as soon as found  to lessen performance overhead from particularly large tables
        end
    end
end
