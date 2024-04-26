local mod = get_mod("my_blessings")

mod:add_global_localize_strings({
	my_blessings_display_name = {
		en = "My Blessings",
	}
})

return {
	mod_title = {
		en = "My Blessings",
	},
	open_my_blessings = {
		en = "Open My Blessings"
	},
	mod_description = {
		en = "Displays all blessings that you have earned",
	},
	enable_debug_mode = {
        en = "Enable Debug Mode",
    },
}
