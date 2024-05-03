return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`my_blessings` encountered an error loading the Darktide Mod Framework.")

		new_mod("my_blessings", {
			mod_script       = "my_blessings/scripts/mods/my_blessings/my_blessings",
			mod_data         = "my_blessings/scripts/mods/my_blessings/my_blessings_data",
			mod_localization = "my_blessings/scripts/mods/my_blessings/my_blessings_localization",
		})
	end,
	packages = {},
}
