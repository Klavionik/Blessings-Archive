local mod = get_mod("my_blessings")
local TextUtilities = require("scripts/utilities/ui/text")
local UIRenderer = require("scripts/managers/ui/ui_renderer")
local UIFonts = require("scripts/managers/ui/ui_fonts")

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

            if trait.weapons and #trait.weapons > 0 then
                widget.content.weapons = fits_on_localized .. " " .. table.concat(weapon_names, ", ")
            else
                widget.content.weapons = mod:localize("fits_any_weapon")
            end

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
        end
    },
}

local DropdownPassTemplates = require("scripts/ui/pass_templates/dropdown_pass_templates")
local dropdown_width = 450

blueprints.dropdown = {
    size = {
        dropdown_width,
        50
    },
    pass_template_function = function (entry)
        local options = entry.options_function and entry.options_function() or entry.options
        local num_visible_options = math.min(#options, 8)

        return DropdownPassTemplates.settings_dropdown(dropdown_width, 50, dropdown_width, num_visible_options, true)
    end,
    init = function (parent, widget, entry, callback_name)
        local content = widget.content
        --Empty string means no dropdown
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
        local scroll_area_height = 600

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

            --Change default font size.
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

return settings("MyBlessingsViewContentBlueprints", blueprints)