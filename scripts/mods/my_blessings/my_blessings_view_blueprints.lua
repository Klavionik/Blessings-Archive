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

            if trait.weapons and #trait.weapons > 0 then
                widget.content.weapons = fits_on_localized .. " " .. table.concat(trait.weapons, ", ")
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
    }
}

return settings("MyBlessingsViewContentBlueprints", blueprints)