SEAS = {}
SEAS.G = {}
SEAS.G.CONFIG = {}
SEAS.FUNC = {}
SEAS.FUNC.UTILS = {}

SEAS.G.CONFIG.flavor_text = true
--[[
    Given an input folder, loads a folder and all of it's children.
    user is expected to deliver the ENTIRE path in the arg, use
    SMODS.current_mod.path for this


]]
function SEAS.FUNC.UTILS.LoadFolderRecursively(path)
    local nfs = require("nativefs")
    local modPath = SMODS.current_mod.path
    local function scan(currentPath)
        local files = nfs.getDirectoryItemsInfo(currentPath)

        for _, fileInfo in ipairs(files) do
            local fileName = fileInfo.name
            local fileType = fileInfo.type
            local childPath = currentPath .. fileName

            if fileType == "directory" then
                -- This is the secret sauce that lets me scan subdirectories too yay woohoo
                scan(childPath .. '/')
            elseif fileType == "file" and fileName:sub(-4) == ".lua" then
                -- loads the file into smods
                local relativePath = childPath:sub(#modPath + 1)
                assert(SMODS.load_file(relativePath))()
                print("Seasoning | Successfully Loaded " .. relativePath)
            end
        end
    end
    scan(path)
end

SEAS.FUNC.UTILS.LoadFolderRecursively(SMODS.current_mod.path .. 'content/')
