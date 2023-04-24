Zones = {
    ["Config"] = {
        debug = false,
        minScore = 10
    },

    ["Territories"] = {

        [1] = {
            centre = vector3(1467.97, -1507.18, 64.09), 
            radius = 180.0,
            winner = "neutral",
            occupants = {},
            blip = 437,
            winnerblip = 84, --Blip will change to this after zone has been captured.
        },

    },

    ["Colours"] = {
        ["neutral"] = 0,
        ["307 Boyz"] = 4,
        ["Vercetti Cartel"] = 6,
    },

    ["Gangs"] = {
        ["307b"] = {
            color = 4,
            name = "307 Boyz's Turf",
        },
        ["vct"] = {
            color = 6,
            name = "Vercetti Cartel's Turf",
        },
        ["neutral"] = {
            color = 0,
            name = "Turf War",
        },
    },
}
