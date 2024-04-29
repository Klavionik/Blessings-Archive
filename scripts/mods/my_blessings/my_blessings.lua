local mod = get_mod("my_blessings")

local UISoundEvents = require("scripts/settings/ui/ui_sound_events")
local WwiseGameSyncSettings = require("scripts/settings/wwise_game_sync/wwise_game_sync_settings")

mod:add_require_path("my_blessings/scripts/mods/my_blessings/my_blessings_view")

mod:register_view({
	view_name = "my_blessings_view",
	view_settings = {
		init_view_function = function(ingame_ui_context)
			return true
		end,
		state_bound = true,
		display_name = "loc_eye_color_sienna_desc", -- Only used for debug
		path = "my_blessings/scripts/mods/my_blessings/my_blessings_view",
		-- package = "", -- Optional package to load with view
		class = "MyBlessingsView",
		disable_game_world = false,
		load_always = true,
		load_in_hub = true,
		game_world_blur = 1.2,
		enter_sound_events = {
			UISoundEvents.system_menu_enter,
		},
		exit_sound_events = {
			UISoundEvents.system_menu_exit,
		},
		wwise_states = {
			options = WwiseGameSyncSettings.state_groups.options.ingame_menu,
		},
	},
	view_transitions = {},
	view_options = {
		close_all = false,
		close_previous = false,
		close_transition_time = nil,
		transition_time = nil,
	},
})


mod:hook(CLASS.ViewElemenMissionBoardOptions, "present", function(func, self, presentation_data)
	func(self, presentation_data)
	
	mod:dump(presentation_data[1], "***PRESENTATION_DATA***", 3)
	mod:dump(presentation_data[1].options_function(), "**OPTIONS**", 2)
end)