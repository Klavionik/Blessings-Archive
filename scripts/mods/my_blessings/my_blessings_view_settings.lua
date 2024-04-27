local grid_width = 1280
local grid_height = 800

local my_blessings_view_settings = {
    scrollbar_width = 10,
    max_visible_dropdown_options = 5,
    shading_environment = "content/shading_environments/ui/system_menu",
    grid_width = grid_width,
    grid_height = grid_height,
    grid_size = {grid_width, grid_height},
    grid_spacing = {20, 30},
    grid_blur_edge_size = {10, 10},
}

return settings("MyBlessingsViewSettings", my_blessings_view_settings)