SEAS = {}
SEAS.G = {}

SEAS.FUNC = {}
SEAS.FUNC.UTILS = {}
--[[
    Given an input folder, loads a folder and all of it's children.
    user is expected to deliver the ENTIRE path in the arg, use
    SMODS.current_mod.path for this


]]
function SEAS.FUNC.UTILS.LoadFolderRecursively(path)
    local nfs = require("nativefs")
    local function scan(currentPath)
        local files = nfs.getDirectoryItemsInfo(path)

        for _, fileInfo in ipairs(files) do
            local fileName = fileInfo.name
            local fileType = fileInfo.type
            local childPath = currentPath == "" and fileName or currentPath .. "/" .. fileName

            if fileType == "directory" then
                -- This is the secret sauce that lets me scan subdirectories too yay woohoo
                scan(childPath)
            elseif fileType == "file" and fileName:sub(-4) == ".lua" then
                -- loads the file into smods
                assert(SMODS.load_file(childPath))()
                print("Seasoning | Successfully Loaded " .. childPath)
            end
        end
    end
    scan(path)
end
