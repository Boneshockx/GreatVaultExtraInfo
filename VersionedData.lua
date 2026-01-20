local ADDON_NAME = ...
local Private = select(2, ...)

VersionedData = {
    tracks = {
        [98] = "Explorer",
        [99] = "Explorer",
        [100] = "Explorer",
        [101] = "Explorer",
        [102] = "Adventurer",
        [103] = "Adventurer",
        [104] = "Adventurer",
        [105] = "Adventurer",
        [108] = "Veteran",
        [111] = "Veteran",
        [115] = "Veteran",
        [118] = "Veteran",
        [121] = "Champion",
        [124] = "Champion",
        [128] = "Champion",
        [131] = "Champion",
        [134] = "Hero",
        [137] = "Hero",
        [141] = "Hero",
        [144] = "Hero",
        [147] = "Myth",
        [150] = "Myth",
        [154] = "Myth",
        [157] = "Myth",
        [160] = "Myth",
        [167] = "Myth",
        [170] = "Myth",
        [170] = "Myth",
    },
    colors = {
        ["Explorer"] = {153, 153, 153},
        ["Adventurer"] = {217, 217, 217},
        ["Veteran"] = {86, 198, 128},
        ["Champion"] = {90, 145, 200},
        ["Hero"] = {171, 22, 232},
        ["Myth"] = {255, 127, 0},
    },

    raid = {
        rows = {1,2,3,4,5,6,7,8},
        headers = {
            [1] = "LFR",
            [2] = "Normal",
            [3] = "Heroic",
            [4] = "Mythic",
        },
        ilevels = {
            [1] = { ["LFR"] = 111, ["Normal"] = 124, ["Heroic"] = 137, ["Mythic"] = 150 },
            [2] = { ["LFR"] = 111, ["Normal"] = 124, ["Heroic"] = 137, ["Mythic"] = 150 },
            [3] = { ["LFR"] = 111, ["Normal"] = 124, ["Heroic"] = 137, ["Mythic"] = 150 },
            [4] = { ["LFR"] = 115, ["Normal"] = 128, ["Heroic"] = 141, ["Mythic"] = 154 },
            [5] = { ["LFR"] = 115, ["Normal"] = 128, ["Heroic"] = 141, ["Mythic"] = 154 },
            [6] = { ["LFR"] = 115, ["Normal"] = 128, ["Heroic"] = 141, ["Mythic"] = 154 },
            [7] = { ["LFR"] = 118, ["Normal"] = 131, ["Heroic"] = 144, ["Mythic"] = 157 },
            [8] = { ["LFR"] = 118, ["Normal"] = 131, ["Heroic"] = 144, ["Mythic"] = 157 },
        },
        -- rares = {
        --     ["LFR"] = 639,
        --     ["Normal"] = 652,
        --     ["Heroic"] = 665,
        --     ["Mythic"] = 678,
        -- },
    },

    mythicplus = {
        rows = {
            [1] = "Run",
            [2] = "Vault"
        },
        headers = {
            [1] = "+2", [2] = "+3", [3] = "+4", [4] = "+5", [5] = "+6",
            [6] = "+7", [7] = "+8", [8] = "+9", [9] = "+10",
        },
        ilevels = {
            [1] = { 
                ["+2"] = 124, ["+3"] = 124, ["+4"] = 128 , ["+5"] = 131, 
                ["+6"] = 134, ["+7"] = 134, ["+8"] = 137, ["+9"] = 137, ["+10"] = 141, 
            },
            [2] = { 
                ["+2"] = 134, ["+3"] = 134, ["+4"] = 137 , ["+5"] = 137, 
                ["+6"] = 141, ["+7"] = 144, ["+8"] = 144, ["+9"] = 144, ["+10"] = 147, 
            },
        },
    },

    delves = {
        rows = {"Run", "Vault"},
        headers = {1, 2, 3, 4, 5, 6, 7, 8},
        ilevels = {
            [1] = { [1] = 102, [2] = 103, [3] = 104, [4] = 105, [5] = 108, [6] = 111, [7] = 121, [8] = 124 },
            [2] = { [1] = 108, [2] = 111, [3] = 115, [4] = 118, [5] = 121, [6] = 128, [7] = 131, [8] = 134 },
        },
    }
}


Private.VersionedData = VersionedData