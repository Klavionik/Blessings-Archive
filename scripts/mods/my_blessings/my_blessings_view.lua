local mod = get_mod("my_blessings")
local debug_mode = mod:get("enable_debug_mode")

local Promise = require("scripts/foundation/utilities/promise")
local ItemUtils = require("scripts/utilities/items")
local MasterItems = require("scripts/backend/master_items")
local ScriptWorld = require("scripts/foundation/utilities/script_world")
local ViewElementInputLegend = require("scripts/ui/view_elements/view_element_input_legend/view_element_input_legend")
local UIWidget = require("scripts/managers/ui/ui_widget")
local UIRenderer = require("scripts/managers/ui/ui_renderer")
local UIFonts = require("scripts/managers/ui/ui_fonts")
local UIWidgetGrid = require("scripts/ui/widget_logic/ui_widget_grid")

local definitions = mod:io_dofile("my_blessings/scripts/mods/my_blessings/my_blessings_view_definitions")
local blueprints = mod:io_dofile("my_blessings/scripts/mods/my_blessings/my_blessings_view_blueprints")

local TRAIT_CATEGORIES = {
    "bespoke_autogun_p1",
    "bespoke_autogun_p2",
    "bespoke_autogun_p3",
    "bespoke_autopistol_p1",
    "bespoke_bolter_p1",
    "bespoke_chainaxe_p1",
    "bespoke_chainsword_2h_p1",
    "bespoke_chainsword_p1",
    "bespoke_combataxe_p1",
    "bespoke_combataxe_p2",
    "bespoke_combataxe_p3",
    "bespoke_combatknife_p1",
    "bespoke_combatsword_p1",
    "bespoke_combatsword_p2",
    "bespoke_combatsword_p3",
    "bespoke_flamer_p1",
    "bespoke_forcestaff_p1",
    "bespoke_forcestaff_p2",
    "bespoke_forcestaff_p3",
    "bespoke_forcestaff_p4",
    "bespoke_forcesword_p1",
    "bespoke_lasgun_p1",
    "bespoke_lasgun_p2",
    "bespoke_lasgun_p3",
    "bespoke_laspistol_p1",
    "bespoke_ogryn_club_p1",
    "bespoke_ogryn_club_p2",
    "bespoke_ogryn_combatblade_p1",
    "bespoke_ogryn_gauntlet_p1",
    "bespoke_ogryn_heavystubber_p1",
    "bespoke_ogryn_powermaul_p1",
    "bespoke_plasmagun_p1",
    "bespoke_powermaul_2h_p1",
    "bespoke_powermaul_p1",
    "bespoke_powersword_p1",
    "bespoke_shotgun_p1",
    "bespoke_stubrevolver_p1",
    "bespoke_thunderhammer_2h_p1",
}

MyBlessingsView = class("MyBlessingsView", "BaseView")

MyBlessingsView.init = function(self, settings)
	self._settings = mod:io_dofile("my_blessings/scripts/mods/my_blessings/my_blessings_view_settings")
    self._traits = nil
    self._blessing_widgets = nil
    self._blessing_grid = nil
    self._ready = false
    self._content_scenegraph_id = "canvas"
    self._grid_scenegraph_id = "grid"
	MyBlessingsView.super.init(self, definitions, settings)
end

MyBlessingsView.on_enter = function(self)
	MyBlessingsView.super.on_enter(self)

	self:_setup_input_legend()
    self:_create_offscreen_renderer()
    self:_update_traits(TRAIT_CATEGORIES)
end

MyBlessingsView._setup_input_legend = function(self)
	self._input_legend_element = self:_add_element(ViewElementInputLegend, "input_legend", 10)
	local legend_inputs = self._definitions.legend_inputs

	for i = 1, #legend_inputs do
		local legend_input = legend_inputs[i]
		local on_pressed_callback = legend_input.on_pressed_callback
			and callback(self, legend_input.on_pressed_callback)

		self._input_legend_element:add_entry(
			legend_input.display_name,
			legend_input.input_action,
			legend_input.visibility_function,
			on_pressed_callback,
			legend_input.alignment
		)
	end
end

local get_weapons = function ()
    local items = Managers.backend.interfaces.master_data:items_cache():get_cached()
    local weapons = {}

    for _, item in pairs(items) do
        local is_weapon = item.item_type == "WEAPON_RANGED" or item.item_type == "WEAPON_MELEE"
        local name = item.display_name
        local bot_weapon = string.match(name, "npc") or string.match(name, "bot")

        if is_weapon and not bot_weapon and name ~= "" then
            local localized_name = Localize(name):match("^%s*(.-)%s*$") --Strip possible whitespaces.

            if weapons[item.parent_pattern] ~= nil then
                local i = #weapons[item.parent_pattern] + 1
                weapons[item.parent_pattern][i] = localized_name
            else
                weapons[item.parent_pattern] = {}
                weapons[item.parent_pattern][1] = localized_name
            end
        end

        ::continue::
    end

    if debug_mode then
        mod:dump(weapons, "weapons", 3)
    end

    return weapons
end

MyBlessingsView._update_traits = function(self, categories)
    self._traits = {}

    local profile = Managers.player:local_player_backend_profile()
    local character_id = profile and profile.character_id
    local weapons = get_weapons()

    local promises = {}

    local function process_category(traits)
        for trait_name, seen_status in pairs(traits) do
            for rank = 1, 4 do
                if seen_status[rank] == "seen" then
                    local fake_trait = {
                        count = 1,
                        characterId = character_id,
                        masterDataInstance = {
                            id = trait_name,
                            overrides = {
                                rarity = rank
                            }
                        },
                        trait_name = trait_name,
                        uuid = math.uuid(),
                        weapon = string.match(trait_name, "^content/items/traits/([%w_]+)/")
                    }

                    local trait = MasterItems.get_item_instance(fake_trait, fake_trait.uuid)
                    local desc = ItemUtils.trait_description(trait, trait.rarity, trait.value)
                    local name = ItemUtils.display_name(trait)

                    local weapon_restriction = trait.weapon_type_restriction[1]
                    local fit_weapons = weapons[weapon_restriction] or {}

                    local trait_data = {
                        trait_id = trait.name,
                        desc = desc,
                        name = name,
                        rarity = trait.rarity,
                        weapons = fit_weapons,
                        value = trait.value,
                        category = ItemUtils.trait_category(trait)
                    }
                    
                    if debug_mode then
                        mod:dump(trait_data, "trait_data_" .. trait.name, 4)
                    end

                    self._traits[#self._traits + 1] = trait_data
                end
            end
        end
    end

    local function log_error(error)
        mod:warning("Error fetching traits data. Code: %s, msg: %s", error.status, error.body)
    end

    for _, category in pairs(categories) do
        local promise = Managers.data_service.crafting:trait_sticker_book(category)
        promise:next(process_category)
        promise:catch(log_error)
        promises[#promises + 1] = promise
    end

    Promise.all(unpack(promises)):next(function ()
        self:_prepare_data()
    end):catch(function (error)
        mod:warning("Error fetching traits data")
        mod:dump(error, "error", 3)
    end)
end

MyBlessingsView._prepare_data = function (self)
    -- Sort traits by rarity, then name.
    table.sort(self._traits, function (a, b)
        return a.rarity < b.rarity or (a.rarity == b.rarity and a.name < b.name)
    end)

    self:_create_blessing_widgets()
    self:_create_grid()

    self._ready = true
end

MyBlessingsView._on_back_pressed = function(self)
	Managers.ui:close_view(self.view_name)
end

MyBlessingsView._destroy_renderer = function(self)
	if self._offscreen_ui_renderer then
		self._offscreen_ui_renderer = nil
	end

	local world_data = self._offscreen_world

	if world_data then
		Managers.ui:destroy_renderer(world_data.renderer_name)
		ScriptWorld.destroy_viewport(world_data.world, world_data.viewport_name)
		Managers.ui:destroy_world(world_data.world)

		world_data = nil
	end
end

MyBlessingsView.update = function(self, dt, t, input_service)
    if self._blessing_grid then
        self._blessing_grid:update(dt, t, input_service)
    end
	return MyBlessingsView.super.update(self, dt, t, input_service)
end

MyBlessingsView._create_blessing_widgets = function(self)
	local blueprint = blueprints.blessing
	local widgets = {}
	local definition = UIWidget.create_definition(blueprint.pass_template, self._grid_scenegraph_id, nil, blueprint.size)

	for i = 1, #self._traits do
		local trait = self._traits[i]
		local widget = UIWidget.init("blessing_" .. i, definition)
		blueprint.init(self._offscreen_ui_renderer, widget, trait)
		local style = widget.style

		local title_height = self:_get_text_height(widget.content.title, style.title)
		local description_height = self:_get_text_height(widget.content.description, style.description)
		local weapons_height = self:_get_text_height(widget.content.weapons, style.weapons)

		style.title.size[2] = title_height
		style.description.size[2] = description_height
		style.weapons.offset[2] = title_height + description_height + 45
		style.weapons.size[2] = weapons_height

		widgets[#widgets + 1] = widget
	end

	self._blessing_widgets = widgets
end

MyBlessingsView._get_text_height = function(self, text, text_style, optional_text_size)
	local ui_renderer = self._offscreen_ui_renderer
	local text_options = UIFonts.get_font_options_by_style(text_style)
	local text_height = UIRenderer.text_height(ui_renderer, text, text_style.font_type, text_style.font_size, optional_text_size or text_style.size, text_options)

	return text_height
end

MyBlessingsView._create_offscreen_renderer = function(self)
	local view_name = self.view_name
	local world_layer = 10
	local world_name = self.__class_name .. "_ui_offscreen_world"
	local world = Managers.ui:create_world(world_name, world_layer, nil, view_name)
	local viewport_name = "offscreen_viewport"
	local viewport_type = "overlay_offscreen"
	local viewport_layer = 1
	local viewport = Managers.ui:create_viewport(world, viewport_name, viewport_type, viewport_layer)
	local renderer_name = self.__class_name .. "offscreen_renderer"

	self._offscreen_ui_renderer = Managers.ui:create_renderer(renderer_name, world)
	self._offscreen_world = {
		name = world_name,
		world = world,
		viewport = viewport,
		viewport_name = viewport_name,
		renderer_name = renderer_name
	}
end


MyBlessingsView._create_grid = function (self)
    local grid_spacing = {20, 30}
    local alignments = self._blessing_widgets
    local direction = "down"
    local grid = UIWidgetGrid:new(
		self._blessing_widgets,
		alignments,
		self._ui_scenegraph,
		self._content_scenegraph_id,
		direction,
		grid_spacing,
		nil
	)

    grid:set_render_scale(self._render_scale)

    local scrollbar_widget = self._widgets_by_name["scrollbar"]
	scrollbar_widget.content.scroll_speed = 100
    grid:assign_scrollbar(scrollbar_widget, self._grid_scenegraph_id, self._content_scenegraph_id)
    grid:set_scrollbar_progress(0)

    self._blessing_grid = grid
end

MyBlessingsView._draw_blessings = function(self, dt, input_service)
    local render_settings = self._render_settings
    local ui_renderer = self._offscreen_ui_renderer
    local ui_scenegraph = self._ui_scenegraph

    UIRenderer.begin_pass(ui_renderer, ui_scenegraph, input_service, dt, render_settings)

    for j = 1, #self._blessing_widgets do
        local widget = self._blessing_widgets[j]

		if self._blessing_grid:is_widget_visible(widget) then
			UIWidget.draw(widget, ui_renderer)
		end
    end

    UIRenderer.end_pass(ui_renderer)
end

MyBlessingsView.draw = function(self, dt, t, input_service, layer)
	self:_draw_elements(dt, t, self._ui_renderer, self._render_settings, input_service)

	if self._ready then
		self:_draw_blessings(dt, input_service)
	end

	MyBlessingsView.super.draw(self, dt, t, input_service, layer)
end


MyBlessingsView._draw_widgets = function(self, dt, t, input_service, ui_renderer, render_settings)
	MyBlessingsView.super._draw_widgets(self, dt, t, input_service, ui_renderer, render_settings)
end

MyBlessingsView.on_exit = function(self)
	MyBlessingsView.super.on_exit(self)

	self:_destroy_renderer()
end

return MyBlessingsView