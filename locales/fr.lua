local Translations = {
    error = {
        enter_gangzone = "Vous êtes entré sur le territoire d'un gang !",
        leave_gangzone = "Vous avez quitté le territoire d'un gang !",
        hostile_zone = "Zone Hostile",
        member_not_connected = "Pas assez de membres ennemies connecter !",
    }
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
