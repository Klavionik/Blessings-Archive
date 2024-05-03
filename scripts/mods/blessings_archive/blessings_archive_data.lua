local mod = get_mod("blessings_archive")

return {
	name = mod:localize("mod_title"),
	description = mod:localize("mod_description"),
	is_togglable = false,
	options = {
		widgets = {
			{setting_id = "open_blessings_archive",
				type = "keybind",
				default_value = {"f6"},
				keybind_trigger = "pressed",
				keybind_type = "view_toggle",
				view_name = "blessings_archive_view"
			},
			{
                setting_id = "debug_mode",
                type = "checkbox",
                default_value = false,
            }
		}
	}
}
