local mod = get_mod("my_blessings")

mod:add_global_localize_strings({
	cycle_tier = {
		en = "Tier: any",
		ru = "Уровень: любой"
	},
	tier_1 = {
		en = "Tier: I",
		ru = "Уровень: I"
	},
	tier_2 = {
		en = "Tier: II",
		ru = "Уровень: II"
	},
	tier_3 = {
		en = "Tier: III",
		ru = "Уровень: III"
	},
	tier_4 = {
		en = "Tier: IV",
		ru = "Уровень: IV"
	}
})

return {
	mod_title = {
		en = "My Blessings",
		ru = "Мои благословения"
	},
	open_my_blessings = {
		en = "Open My Blessings",
		ru = "Открыть мои благословения"
	},
	mod_description = {
		en = "Displays all blessings that you have earned",
		ru = "Показывает все имеющиеся благословения"
	},
	debug_mode = {
        en = "Debug Mode",
		ru = "Режим отладки"
    },
	fits_any_weapon = {
		en = "Fits on any weapon",
		ru = "Подходит к любому оружию"
	},
	fits_weapon = {
		en = "Fits on:",
		ru = "Подходит к:"
	},
}
