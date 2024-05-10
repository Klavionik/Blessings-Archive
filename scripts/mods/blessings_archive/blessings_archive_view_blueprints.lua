local mod = get_mod("blessings_archive")

local ColorUtilities = require("scripts/utilities/ui/colors")
local TextUtilities = require("scripts/utilities/ui/text")
local UIRenderer = require("scripts/managers/ui/ui_renderer")
local UIFonts = require("scripts/managers/ui/ui_fonts")
local UIFontSettings = require("scripts/managers/ui/ui_font_settings")
local UISoundEvents = require("scripts/settings/ui/ui_sound_events")

local function get_text_height(ui_renderer, text, text_style, optional_text_size)
	local text_options = UIFonts.get_font_options_by_style(text_style)
	local text_height = UIRenderer.text_height(ui_renderer, text, text_style.font_type, text_style.font_size, optional_text_size or text_style.size, text_options)

	return text_height
end

local blueprints = {
    blessing = {
        -- Size is calculated dynamically in init method.
        size = {
            0,
            0,
        },
        pass_template = {
            {
                pass_type = "rect",
                style = {
                    color = {
                        220,
                        0,
                        0,
                        0
                    }
                }
            },
            {
                value = "content/ui/materials/backgrounds/default_square",
                style_id = "background",
                pass_type = "texture",
                style = {
                    color = Color.terminal_background(nil, true)
                }
            },
            {
                value = "content/ui/materials/gradients/gradient_vertical",
                style_id = "background_gradient",
                pass_type = "texture",
                style = {
                    vertical_alignment = "center",
                    horizontal_alignment = "center",
                    color = Color.terminal_background_gradient(180, true),
                    offset = {
                        0,
                        0,
                        1
                    }
                }
            },
            {
                value = "content/ui/materials/frames/dropshadow_medium",
                style_id = "outer_shadow",
                pass_type = "texture",
                style = {
                    vertical_alignment = "center",
                    horizontal_alignment = "center",
                    scale_to_material = true,
                    color = Color.black(200, true),
                    size_addition = {
                        20,
                        20
                    },
                    offset = {
                        0,
                        0,
                        3
                    }
                }
            },
            {
                value = "content/ui/materials/frames/frame_tile_2px",
                style_id = "frame",
                pass_type = "texture",
                style = {
                    vertical_alignment = "center",
                    horizontal_alignment = "center",
                    color = Color.terminal_frame(nil, true),
                    offset = {
                        0,
                        0,
                        2
                    }
                }
            },
            {
                value = "content/ui/materials/frames/frame_corner_2px",
                style_id = "corner",
                pass_type = "texture",
                style = {
                    vertical_alignment = "center",
                    horizontal_alignment = "center",
                    color = Color.terminal_corner(nil, true),
                    offset = {
                        0,
                        0,
                        3
                    }
                }
            },
            {
                value_id = "title",
                pass_type = "text",
                style_id = "title",
                value = "n/a",
                style = {
                    text_vertical_alignment = "top",
                    horizontal_alignment = "center",
                    font_size = 22,
                    text_horizontal_alignment = "left",
                    vertical_alignment = "top",
                    font_type = "proxima_nova_bold",
                    text_color = Color.terminal_text_header(255, true),
                    color = {
                        100,
                        255,
                        200,
                        50
                    },
                    size = {
                        nil,
                        0
                    },
                    offset = {
                        10,
                        10,
                        1
                    },
                }
            },
            {
                value_id = "description",
                pass_type = "text",
                style_id = "description",
                value = "n/a",
                style = {
                    font_size = 18,
                    text_vertical_alignment = "top",
                    horizontal_alignment = "left",
                    text_horizontal_alignment = "left",
                    vertical_alignment = "top",
                    font_type = "proxima_nova_bold",
                    text_color = Color.terminal_text_body(255, true),
                    size = {
                        330,
                        0
                    },
                    offset = {
                        10,
                        40,
                        1
                    },
                },
            },
            {
                value_id = "weapons",
                pass_type = "text",
                style_id = "weapons",
                value = "n/a",
                style = {
                    font_size = 15,
                    text_vertical_alignment = "top",
                    horizontal_alignment = "left",
                    text_horizontal_alignment = "left",
                    vertical_alignment = "top",
                    font_type = "proxima_nova_bold",
                    text_color = Color.ui_terminal(255, true),
                    size = {
                        330,
                        0
                    },
                    offset = {
                        10,
                        0,
                        1
                    },
                },
            }
        },
        init = function (ui_renderer, widget, trait)
            widget.content.title = trait.name .. " " .. TextUtilities.convert_to_roman_numerals(trait.rarity)
            widget.content.description = trait.desc
            widget._trait_rarity = trait.rarity
            local fits_on_localized = mod:localize("fits_weapon")

            local weapon_names = {}

            for _, weapon in pairs(trait.weapons) do
                weapon_names[#weapon_names + 1] = weapon.localized_name
            end

            widget.content.weapons = fits_on_localized .. " " .. table.concat(weapon_names, ", ")

            local style = widget.style

            local title_height = get_text_height(ui_renderer, widget.content.title, style.title)
            local description_height = get_text_height(ui_renderer, widget.content.description, style.description)
            local weapons_height = get_text_height(ui_renderer, widget.content.weapons, style.weapons)

            local total_offset = 50
            local bottom_margin = 10
    
            style.title.size[2] = title_height
            style.description.size[2] = description_height
            style.weapons.offset[2] = title_height + description_height + total_offset
            style.weapons.size[2] = weapons_height

            local total_height = title_height + description_height + weapons_height + total_offset + bottom_margin

            widget.content.size = {350, total_height}

            if not trait.is_seen then
                style.background_gradient.color = Color.ui_grey_medium(255, true)
                style.frame.color = Color.ui_grey_medium(0, true)
                style.corner.color = Color.ui_grey_medium(255, true)
                style.title.text_color = Color.ui_grey_light(255, true)
                style.description.text_color = Color.ui_grey_light(255, true)
                style.weapons.text_color = Color.ui_grey_light(255, true)
            end
        end
    },
}

local DropdownPassTemplates = require("scripts/ui/pass_templates/dropdown_pass_templates")
local dropdown_width = 450
local dropdown_height = 50
local scroll_area_height = 600

blueprints.dropdown = {
    size = {
        dropdown_width,
        dropdown_height
    },
    pass_template_function = function (entry)
        local options = entry.options_function and entry.options_function() or entry.options
        local num_visible_options = math.min(#options, 8)

        return DropdownPassTemplates.settings_dropdown(dropdown_width, dropdown_height, dropdown_width, num_visible_options, true)
    end,
    init = function (parent, widget, entry, callback_name)
        local content = widget.content
        -- Empty string means no dropdown label.
        content.text = ""
        content.entry = entry
        local options = entry.options or entry.options_function and entry.options_function()
        local num_options = #options
        local num_visible_options = math.min(num_options, 8)
        content.num_visible_options = num_visible_options
        local optional_num_decimals = entry.optional_num_decimals
        local number_format = string.format("%%.%sf", optional_num_decimals or 0)
        local options_by_id = {}

        for i = 1, num_options do
            local option = options[i]
            options_by_id[option.id] = option
        end

        content.number_format = number_format
        content.options_by_id = options_by_id
        content.options = options
        content.hotspot.pressed_callback = callback(parent, callback_name, widget, entry)
        local widget_type = widget.type
        local template = blueprints[widget_type]
        local size = template.size
        content.area_length = size[2] * num_visible_options
        local scroll_length = math.max(size[2] * num_options - content.area_length, 0)
        content.scroll_length = scroll_length
        local spacing = 0
        local scroll_amount = scroll_length > 0 and (size[2] + spacing) / scroll_length or 0
        content.scroll_amount = scroll_amount
    end,
    update = function (parent, widget, input_service, dt, t)
        local offset = widget.offset
        local content = widget.content
        local style = widget.style
        local entry = content.entry
        local options = content.options
        local options_by_id = content.options_by_id
        local num_visible_options = content.num_visible_options
        local num_options = #options
        local focused = content.exclusive_focus

        if focused and parent:can_exit() then
            content.selected_index = nil

            parent:set_can_exit(false)
        end

        local selected_index = content.selected_index
        local value, new_value = nil
        local hotspot_style = style.hotspot

        if selected_index and focused then
            hotspot_style.on_pressed_sound = hotspot_style.on_pressed_fold_in_sound
        else
            hotspot_style.on_pressed_sound = hotspot_style.on_pressed_fold_out_sound
        end

        value = entry.get_function and entry.get_function() or content.internal_value or "<not selected>"
        local localization_manager = Managers.localization
        local preview_option = options_by_id[value]
        local preview_option_id = preview_option and preview_option.i
        local preview_value = preview_option and preview_option.display_name or "n/a"
        local ignore_localization = preview_option and preview_option.ignore_localization
        content.value_text = ignore_localization and preview_value or localization_manager:localize(preview_value)
        local widget_type = widget.type
        local template = blueprints[widget_type]
        local size = template.size
        local scroll_amount = 0

        local dropdown_length = size[2] * (num_visible_options + 1)
        local grow_downwards = true

        if scroll_area_height <= offset[2] - scroll_amount + dropdown_length then
            grow_downwards = false
        end

        content.grow_downwards = grow_downwards
        local new_selection_index = nil

        if not selected_index or not focused then
            for i = 1, #options do
                local option = options[i]

                if option.id == preview_option_id then
                    selected_index = i

                    break
                end
            end

            selected_index = selected_index or 1
        end

        if selected_index and focused then
            if input_service:get("navigate_up_continuous") then
                if grow_downwards then
                    new_selection_index = math.max(selected_index - 1, 1)
                else
                    new_selection_index = math.min(selected_index + 1, num_options)
                end
            elseif input_service:get("navigate_down_continuous") then
                if grow_downwards then
                    new_selection_index = math.min(selected_index + 1, num_options)
                else
                    new_selection_index = math.max(selected_index - 1, 1)
                end
            end
        end

        if new_selection_index or not content.selected_index then
            if new_selection_index then
                selected_index = new_selection_index
            end

            if num_visible_options < num_options then
                local step_size = 1 / num_options
                local new_scroll_percentage = math.min(selected_index - 1, num_options) * step_size
                content.scroll_percentage = new_scroll_percentage
                content.scroll_add = nil
            end

            content.selected_index = selected_index
        end

        local scroll_percentage = content.scroll_percentage

        if scroll_percentage then
            local step_size = 1 / (num_options - (num_visible_options - 1))
            content.start_index = math.max(1, math.ceil(scroll_percentage / step_size))
        end

        local option_hovered = false
        local option_index = 1
        local start_index = content.start_index or 1
        local end_index = math.min(start_index + num_visible_options - 1, num_options)
        local using_scrollbar = num_visible_options < num_options

        for i = start_index, end_index do
            local option_text_id = "option_text_" .. option_index
            local option_hotspot_id = "option_hotspot_" .. option_index
            local outline_style_id = "outline_" .. option_index
            local option_hotspot = content[option_hotspot_id]
            option_hovered = option_hovered or option_hotspot.is_hover
            option_hotspot.is_selected = i == selected_index
            local option = options[i]

            if not new_value and focused and option_hotspot.on_pressed then
                option_hotspot.on_pressed = nil
                new_value = option.id
                content.selected_index = i
            end

            local option_display_name = option.display_name
            local option_ignore_localization = option.ignore_localization
            content[option_text_id] = option_ignore_localization and option_display_name or localization_manager:localize(option_display_name)
            local options_y = size[2] * option_index
            style[option_hotspot_id].offset[2] = grow_downwards and options_y or -options_y
            style[option_text_id].offset[2] = grow_downwards and options_y or -options_y
            local entry_length = style[option_hotspot_id].size[1]
            entry_length = using_scrollbar and dropdown_width - style.thumb.size[1] or dropdown_width
            style[outline_style_id].size[1] = entry_length
            style[option_text_id].size[1] = entry_length

            -- Override default font size.
            style[option_text_id].font_size = 20
            style.text.font_size = 20
            option_index = option_index + 1
        end

        local value_changed = new_value ~= nil

        if value_changed and new_value ~= value then
            local on_activated = entry.on_activated

            on_activated(new_value, value)
        end

        local scrollbar_hotspot = content.scrollbar_hotspot
        local scrollbar_hovered = scrollbar_hotspot.is_hover
        local pass_input = value_changed or not option_hovered and not scrollbar_hovered

        return pass_input
    end
}

local tab_menu_button_hotspot_content = {
    on_hover_sound = UISoundEvents.tab_secondary_button_hovered,
    on_pressed_sound = UISoundEvents.tab_secondary_button_pressed
}

local function terminal_button_change_function(content, style, optional_hotspot_id)
    local hotspot = optional_hotspot_id and content[optional_hotspot_id] or content.hotspot
    local is_selected = hotspot.is_selected
    local is_focused = hotspot.is_focused
    local is_hover = hotspot.is_hover
    local disabled = hotspot.disabled
    local default_color = style.default_color
    local hover_color = style.hover_color
    local selected_color = style.selected_color
    local disabled_color = style.disabled_color
    local color = nil

    if disabled and disabled_color then
        color = disabled_color
    elseif (is_selected or is_focused) and selected_color then
        color = selected_color
    elseif is_hover and hover_color then
        color = hover_color
    elseif default_color then
        color = default_color
    end
    --
    if color then
        ColorUtilities.color_copy(color, style.text_color or style.color)
    end
end

local function terminal_button_hover_change_function(content, style, optional_hotspot_id)
    local hotspot = optional_hotspot_id and content[optional_hotspot_id] or content.hotspot
    local anim_hover_progress = hotspot.anim_hover_progress or 0
    local anim_select_progress = hotspot.anim_select_progress or 0
    local anim_focus_progress = hotspot.anim_focus_progres or 0
    local default_alpha = 155
    local hover_alpha = anim_hover_progress * 100
    local select_alpha = math.max(anim_select_progress, anim_focus_progress) * 50
    local style_color = style.text_color or style.color
    style_color[1] = math.clamp(default_alpha + select_alpha + hover_alpha, 0, 255)
end

local simple_button_font_settings = UIFontSettings.button_medium

blueprints.tab_button = {
    {
        style_id = "hotspot",
        pass_type = "hotspot",
        content_id = "hotspot",
        content = tab_menu_button_hotspot_content,
        style = {
            on_hover_sound = UISoundEvents.tab_secondary_button_hovered,
            on_pressed_sound = UISoundEvents.tab_secondary_button_pressed
        }
    },
    {
        pass_type = "texture",
        style_id = "background",
        value = "content/ui/materials/backgrounds/default_square",
        style = {
            default_color = Color.terminal_background(nil, true),
            selected_color = Color.terminal_background_selected(nil, true)
        },
        change_function = terminal_button_change_function
    },
    {
        pass_type = "texture",
        style_id = "background_gradient",
        value = "content/ui/materials/gradients/gradient_vertical",
        style = {
            vertical_alignment = "center",
            horizontal_alignment = "center",
            default_color = Color.terminal_background_gradient(nil, true),
            selected_color = Color.terminal_frame_selected(nil, true),
            offset = {
                0,
                0,
                1
            }
        },
        change_function = function (content, style)
            terminal_button_change_function(content, style)
            terminal_button_hover_change_function(content, style)
        end
    },
    {
        pass_type = "texture",
        style_id = "frame",
        value = "content/ui/materials/frames/frame_tile_2px",
        style = {
            vertical_alignment = "center",
            horizontal_alignment = "center",
            color = Color.terminal_frame(nil, true),
            default_color = Color.terminal_frame(nil, true),
            selected_color = Color.terminal_frame_selected(nil, true),
            hover_color = Color.terminal_frame_hover(nil, true),
            offset = {
                0,
                0,
                12
            }
        },
        change_function = terminal_button_change_function
    },
    {
        pass_type = "texture",
        style_id = "corner",
        value = "content/ui/materials/frames/frame_corner_2px",
        style = {
            vertical_alignment = "center",
            horizontal_alignment = "center",
            color = Color.terminal_corner(nil, true),
            default_color = Color.terminal_corner(nil, true),
            selected_color = Color.terminal_corner_selected(nil, true),
            hover_color = Color.terminal_corner_hover(nil, true),
            offset = {
                0,
                0,
                13
            }
        },
        change_function = terminal_button_change_function
    },
    {
        style_id = "text",
        pass_type = "text",
        value_id = "text",
        style = {
            text_vertical_alignment = "center",
            text_horizontal_alignment = "center",
            offset = {
                0,
                0,
                2
            },
            font_type = simple_button_font_settings.font_type,
            font_size = 22,
            text_color = simple_button_font_settings.text_color,
            default_text_color = simple_button_font_settings.text_color
        },
        change_function = function (content, style)
            local default_text_color = style.default_text_color
            local text_color = style.text_color
            local progress = 1 - content.hotspot.anim_input_progress * 0.3
            text_color[2] = default_text_color[2] * progress
            text_color[3] = default_text_color[3] * progress
            text_color[4] = default_text_color[4] * progress
        end
    },
}

return settings("BlessingsArchiveViewContentBlueprints", blueprints)