local ADDON_NAME = ...
local Private = select(2, ...)

VersionedData = {
    tracks = {
        [642] = "Explorer",
        [646] = "Explorer",
        [649] = "Explorer",
        [652] = "Explorer",
        [655] = "Adventurer",
        [658] = "Adventurer",
        [662] = "Adventurer",
        [665] = "Adventurer",
        [668] = "Veteran",
        [671] = "Veteran",
        [675] = "Veteran",
        [678] = "Veteran",
        [681] = "Champion",
        [684] = "Champion",
        [688] = "Champion",
        [691] = "Champion",
        [694] = "Hero",
        [697] = "Hero",
        [701] = "Hero",
        [704] = "Hero",
        [707] = "Myth",
        [710] = "Myth",
        [714] = "Myth",
        [717] = "Myth",
        [720] = "Myth",
        [723] = "Myth",
        [727] = "Myth",
        [730] = "Myth",
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
            [1] = { ["LFR"] = 671, ["Normal"] = 684, ["Heroic"] = 697, ["Mythic"] = 710 },
            [2] = { ["LFR"] = 671, ["Normal"] = 684, ["Heroic"] = 697, ["Mythic"] = 710 },
            [3] = { ["LFR"] = 671, ["Normal"] = 684, ["Heroic"] = 697, ["Mythic"] = 710 },
            [4] = { ["LFR"] = 675, ["Normal"] = 688, ["Heroic"] = 701, ["Mythic"] = 714 },
            [5] = { ["LFR"] = 675, ["Normal"] = 688, ["Heroic"] = 701, ["Mythic"] = 714 },
            [6] = { ["LFR"] = 675, ["Normal"] = 688, ["Heroic"] = 701, ["Mythic"] = 714 },
            [7] = { ["LFR"] = 678, ["Normal"] = 691, ["Heroic"] = 704, ["Mythic"] = 717 },
            [8] = { ["LFR"] = 678, ["Normal"] = 691, ["Heroic"] = 704, ["Mythic"] = 717 },
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
                ["+2"] = 684, ["+3"] = 684, ["+4"] = 688 , ["+5"] = 691, 
                ["+6"] = 694, ["+7"] = 694, ["+8"] = 697, ["+9"] = 697, ["+10"] = 701, 
            },
            [2] = { 
                ["+2"] = 694, ["+3"] = 694, ["+4"] = 697 , ["+5"] = 697, 
                ["+6"] = 701, ["+7"] = 704, ["+8"] = 704, ["+9"] = 704, ["+10"] = 707, 
            },
        },
    },

    delves = {
        rows = {"Run", "Vault"},
        headers = {1, 2, 3, 4, 5, 6, 7, 8},
        ilevels = {
            [1] = { [1] = 655, [2] = 658, [3] = 662, [4] = 665, [5] = 668, [6] = 671, [7] = 681, [8] = 684 },
            [2] = { [1] = 668, [2] = 671, [3] = 675, [4] = 678, [5] = 681, [6] = 688, [7] = 691, [8] = 694 },
        },
    }
}


Private.VersionedData = VersionedData