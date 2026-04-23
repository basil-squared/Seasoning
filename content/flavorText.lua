local card_h_popup_ref = G.UIDEF.card_h_popup

G.UIDEF.card_h_popup = function(card)
    local ret = card_h_popup_ref(card)
    if not card or not card.config or not card.config.center then return ret end
    if not ret then return ret end
    local center = card.config.center

    -- nab container

    local ok, inner_nodes = pcall(function()
        return ret.nodes[1].nodes[1].nodes[1].nodes
    end)
    if not ok or not inner_nodes then return ret end
    if SEAS.G.CONFIG.flavor_text and center.set and center.key then
        local descs = G.localization.descriptions
        if descs and descs[center.set] then
            local loc_target = descs[center.set][center.key]
            if loc_target and loc_target.flavor_text then
                local flavor_lines = loc_target.flavor_text
                if type(flavor_lines) == "string" then
                    flavor_lines = { flavor_lines }
                end
                local loc_args = {
                    shadow = false,
                    scale = 1,
                    text_colour = G.C.UI.TEXT.DARK,
                    default_col = G.C.UI.TEXT.DARK,
                    vars = { colours = {} },

                }
                local text_rows = {}
                for _, line in ipairs(flavor_lines) do
                    local parsed = loc_parse_string(line)
                    local row_nodes = SMODS.localize_box(parsed, loc_args)
                    text_rows[#text_rows + 1] = {
                        n = G.UIT.R,
                        config = { align = "cm", maxw = 4 },
                        nodes = row_nodes,

                    }
                end
                local flavor_vox = {
                    n = G.UIT.R,
                    config = {
                        align = "cm",
                        colour = G.C.UI.BACKGROUND_WHITE,
                        r = 0.1,
                        padding = 0.04,
                        minw = 2,
                        minh = 0.4,
                        emboss = 0.05,

                    },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0.03 },
                            nodes = text_rows,
                        },
                    },

                }
                for i, node in ipairs(inner_nodes) do
                    if type(node) == "table" and node.config and node.config.filler then
                        table.insert(inner_nodes, i + 1, flavor_vox)
                        break
                    end
                end
            end
        end
    end
    return ret
end
