local mod = get_mod("my_blessings")
local settings = mod:io_dofile("my_blessings/scripts/mods/my_blessings/my_blessings_view_settings")
local UIWidget = require("scripts/managers/ui/ui_widget")
local UIFontSettings = require("scripts/managers/ui/ui_font_settings")
local UIWorkspaceSettings = require("scripts/settings/ui/ui_workspace_settings")
local ScrollbarPassTemplates = require("scripts/ui/pass_templates/scrollbar_pass_templates")

local scenegraph_definition = {
	screen = UIWorkspaceSettings.screen,
    canvas = {
        vertical_alignment = "top",
        parent = "screen",
        horizontal_alignment = "left",
        size = settings.grid_size,
        position = {180, 180, 1}
    },
    grid = {
        vertical_alignment = "top",
        parent = "canvas",
        horizontal_alignment = "left",
        size = {0, 0},
        position = {0, 0, 1}
    },
    grid_mask = {
        vertical_alignment = "center",
        parent = "canvas",
        horizontal_alignment = "center",
        size = {
            settings.grid_width + settings.grid_blur_edge_size[1] * 2,
            settings.grid_height + settings.grid_blur_edge_size[2] * 2,
        },
        position = {0, 0, 0}
    },
    scrollbar = {
        vertical_alignment = "center",
        parent = "canvas",
        horizontal_alignment = "right",
        size = {settings.scrollbar_width, settings.grid_height},
        position = {-150, 0, 1}
    },
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
    filters_title_text = {
        vertical_alignment = "top",
        parent = "scrollbar",
        horizontal_alignment = "left",
        size = {400, 50},
        position = {40, 0, 2}
    },
    weapons_filter = {
        vertical_alignment = "top",
        parent = "filters_title_text",
        horizontal_alignment = "right",
        size = {400, 50},
        position = {0, 60, 2}
    },
    rarity_filter = {
        vertical_alignment = "top",
        parent = "weapons_filter",
        horizontal_alignment = "right",
        size = {400, 50},
        position = {0, 70, 2}
    },
    shown_count = {
        vertical_alignment = "top",
        parent = "rarity_filter",
        horizontal_alignment = "left",
        size = {200, 0},
        position = {0, 80, 2}
    },
    total_count = {
        vertical_alignment = "top",
        parent = "shown_count",
        horizontal_alignment = "left",
        size = {200, 0},
        position = {0, 40, 2}
    }
}

local widget_definitions = {
    overlay = UIWidget.create_definition({
        {
            pass_type = "rect",
            style = {
                offset = {0, 0, 0},
                color = {160, 0, 0, 0},
                visible = false,
            }
        }
    }, "screen"),
    background = UIWidget.create_definition({
        {
            pass_type = "rect",
            style = {
                color = {160, 0, 0, 0}
            }
        }
    }, "screen"),
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
            value = mod:localize("mod_title"),
            style = table.clone(UIFontSettings.header_1)
        }
    }, "title_text"),
    grid_mask = UIWidget.create_definition({
        {
            value = "content/ui/materials/offscreen_masks/ui_overlay_offscreen_vertical_blur",
            pass_type = "texture",
            style = {
                color = {255, 255, 255, 255}
            }
        }
    }, "grid_mask"),
    scrollbar = UIWidget.create_definition(ScrollbarPassTemplates.default_scrollbar, "scrollbar"),
    filters_title_text = UIWidget.create_definition({
        {
            value_id = "text",
            style_id = "text",
            pass_type = "text",
            value = mod:localize("filters_title"),
            style = table.clone(UIFontSettings.header_2)
        }
    }, "filters_title_text"),
    shown_count = UIWidget.create_definition({
        {
            value_id = "text",
            style_id = "text",
            pass_type = "text",
            value = mod:localize("shown_count", 0),
            style = table.clone(UIFontSettings.header_3)
        }
    }, "shown_count"),
    total_count = UIWidget.create_definition({
        {
            value_id = "text",
            style_id = "text",
            pass_type = "text",
            value = mod:localize("total_count", 0),
            style = table.clone(UIFontSettings.header_3)
        }
    }, "total_count"),
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