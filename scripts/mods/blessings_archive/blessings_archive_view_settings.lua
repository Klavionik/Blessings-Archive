local grid_width = 1280
local grid_height = 800

local blessings_archive_view_settings = {
    scrollbar_width = 10,
    grid_width = grid_width,
    grid_height = grid_height,
    grid_size = {grid_width, grid_height},
    grid_spacing = {20, 30},
    grid_blur_edge_size = {10, 10},
}

return settings("BlessingsArchiveViewSettings", blessings_archive_view_settings)