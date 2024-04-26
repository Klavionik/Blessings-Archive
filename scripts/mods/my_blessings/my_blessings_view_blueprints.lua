local TextUtilities = require("scripts/utilities/ui/text")

local blueprints = {
    blessing = {
        size = {
            350,
            200,
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
                        0
                    },
                }
            },
            {
                value_id = "description",
                pass_type = "text",
                style_id = "description",
                value = "n/a",
                style = {
                    font_size = 20,
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
                        5
                    },
                    color = {
                        100,
                        100,
                        255,
                        0
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
                    text_color = Color.terminal_text_header(255, true),
                    size = {
                        330,
                        0
                    },
                    offset = {
                        10,
                        0,
                        5
                    },
                    color = {
                        100,
                        100,
                        255,
                        0
                    },
                },
            }
        },
        init = function (widget, trait)
            widget.content.title = trait.name .. " Tier " .. TextUtilities.convert_to_roman_numerals(trait.rarity)
            widget.content.description = trait.desc

            if trait.weapons then
                widget.content.weapons = "Fits on: " .. table.concat(trait.weapons, ", ")
            else
                widget.content.weapons = "Fits on: any"
            end
        end
    }
}

return settings("MyBlessingsViewContentBlueprints", blueprints)