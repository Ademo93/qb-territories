local Translations = {
    error = {
     	enter_gangzone = "You have entered a gang territory !",
    	leave_gangzone = "You have left a gang territory !",
    	hostile_zone = "Hostile Zone",
    }
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
