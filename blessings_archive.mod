return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`blessings_archive` encountered an error loading the Darktide Mod Framework.")

		new_mod("blessings_archive", {
			mod_script       = "blessings_archive/scripts/mods/blessings_archive/blessings_archive",
			mod_data         = "blessings_archive/scripts/mods/blessings_archive/blessings_archive_data",
			mod_localization = "blessings_archive/scripts/mods/blessings_archive/blessings_archive_localization",
		})
	end,
	packages = {},
}
