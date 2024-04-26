local mod = get_mod("my_blessings")
local settings = mod:io_dofile("my_blessings/scripts/mods/my_blessings/my_blessings_view_settings")
local UIWidget = require("scripts/managers/ui/ui_widget")
local UIFontSettings = require("scripts/managers/ui/ui_font_settings")
local UIWorkspaceSettings = require("scripts/settings/ui/ui_workspace_settings")
local ScrollbarPassTemplates = mod:original_require("scripts/ui/pass_templates/scrollbar_pass_templates")

local scenegraph_definition = {
	screen = UIWorkspaceSettings.screen,
    title_divider = {
        vertical_alignment = "top",
        parent = "screen",
        horizontal_alignment = "left",
        size = {335, 18},
        position = {180, 145, 1}
    },
    title_text = {
        vertical_alignment = "bottom",
        parent = "title_divider",
        horizontal_alignment = "left",
        size = {500, 50},
        position = {0, -35, 1}
    },
    content_pivot = {
        vertical_alignment = "top",
        parent = "title_divider",
        horizontal_alignment = "left",
        size = settings.grid_size,
        position = {0, 30, 1}
    },
    scrollbar = {
        vertical_alignment = "center",
        parent = "content_pivot",
        horizontal_alignment = "right",
        size = {settings.scrollbar_width, settings.grid_size[2]},
        position = {-150, 0, 1}
    },
}

local widget_definitions = {
    title_divider = UIWidget.create_definition({
        {
            pass_type = "texture",
            value = "content/ui/materials/dividers/skull_rendered_left_01"
        }
    }, "title_divider"),
    title_text = UIWidget.create_definition({
        {
            value_id = "text",
            style_id = "text",
            pass_type = "text",
            value = "My Blessings",
            style = table.clone(UIFontSettings.header_1)
        }
    }, "title_text"),
    scrollbar = UIWidget.create_definition(ScrollbarPassTemplates.default_scrollbar, "scrollbar"),
}

local legend_inputs = {
	{
		input_action = "back",
		on_pressed_callback = "_on_back_pressed",
		display_name = "loc_class_selection_button_back",
		alignment = "left_alignment",
	},
}

return {
	scenegraph_definition = scenegraph_definition,
	widget_definitions = widget_definitions,
	legend_inputs = legend_inputs,
}