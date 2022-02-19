Zones = {
    ["Config"] = {
        debug = false,
        minScore = 10
    },

    ["Territories"] = {

        [1] = {
            centre = vector3(755.02, -298.71, 59.89),
            radius = 90.0,
            winner = "tarteret",
            occupants={
                ["tarteret"] = {
                    label = "tarteret",
                    score = 60,
                },
            },
            blip = 437
        },

        [2] = {
            centre = vector3(1373.51, -1534.22, 56.22),
            radius = 90.0,
            winner = "marabunta",
            occupants={},
            blip = 437
        },

        [3] = {
            centre = vector3(1281.96, -1733.7, 52.53),
            radius = 90.0,
            winner = "aztecas",
            occupants={},
            blip = 437
        },

        [4] = {
            centre = vector3(37.38, -1880.71, 22.34),
            radius = 120.0,
            winner = "ballas",
            occupants={},
            blip = 437
        }
    },

    ["Colours"] = {
        ["tarteret"] = 4,
        ["vagos"] = 5,
    },

    ["Gangs"] = {
        ["tarteret"] = {
            color = 4,
            name = "Tarteret",
        },
        ["aztecas"] =  {
            color = 32,
            name = "Aztecas",
        },
        ["ballas"] = {
            color = 27,
            name = "Ballas",
        },
        ["vagos"] = {
            color = 5,
            name = "Vagos",
        },
        ["marabunta"] = {
            color = 29,
            name = "Marabunta",
        },
        ["mafia"] = {
            color = 44,
            name = "Mafia",
        },
        ["neutral"] = {
            color = 0,
            name = "",
        },
    }

}
