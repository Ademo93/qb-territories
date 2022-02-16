Zones = {
    ["Config"] = {
        debug = false,
        minScore = 60
    },

    ["Territories"] = {

        [1] = {
            centre = vector3(755.02, -298.71, 59.89),
            radius = 90.0,
            occupants = {"tarteret"},
            winner = "tarteret",
            --not in use yet
            blip = 437
        },

        [2] = {
            centre = vector3(1373.51, -1534.22, 56.22),
            radius = 90.0,
            occupants = {},
            winner = "Marabunta",
            --not in use yet
            blip = 437
        },

        [3] = {
            centre = vector3(1281.96, -1733.7, 52.53),
            radius = 90.0,
            occupants = {},
            winner = "asteq",
            --not in use yet
            blip = 437
        },

        [4] = {
            centre = vector3(37.38, -1880.71, 22.34),
            radius = 120.0,
            occupants = {},
            winner = "Ballas",
            --not in use yet
            blip = 437
        }
    },

    ["Colours"] = {
        ["Police"] = 38,
        ["tarteret"] = 79,
        ["asteq"] = 32,
        ["Ballas"] = 27,
        ["Vagos"] = 5,
        ["Marabunta"] = 29,
        ["Mafia"] = 44,
        ["The Lost MC"] = 40,
        ["neutral"] = 0
    }
}
