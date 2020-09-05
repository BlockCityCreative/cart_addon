-----------
-- Nodes --
-----------

local bottem_half = "gravel.png"
if minetest.get_modpath("default") then
    bottem_half = "default_stone_block.png"
end

minetest.register_node("cart_addon:cart_gravel", {
	description = "Cart Gravel",
	tiles = {"gravel.png"},
	groups = {crumbly = 2, falling_node = 1},
})

minetest.register_node("cart_addon:solid_cart_gravel", {
    description = "Cart gravel with a base",
    tiles = {
        "gravel.png",
        bottem_half,
        "gravel.png^[lowpart:50:" .. bottem_half,
        "gravel.png^[lowpart:50:" .. bottem_half,
        "gravel.png^[lowpart:50:" .. bottem_half,
        "gravel.png^[lowpart:50:" .. bottem_half,
    },
    groups = {crumbly = 2},
})

if minetest.get_modpath("moreblocks") then
    local subset = {
        { "micro", "" },
        { "slope", "_half" },
        { "slope", "_half_raised" },
        { "slope", "" },
    }

    stairsplus:register_custom_subset(subset, "cart_addon", "cart_gravel", "cart_addon:cart_gravel", {
        description = "Cart Gravel",
        tiles = {"gravel.png"},
        groups = {crumbly = 2, falling_node = 1},
    })

    stairsplus:register_custom_subset(subset, "cart_addon", "solid_cart_gravel", "cart_addon:solid_cart_gravel", {
        description = "Cart gravel with a base",
        tiles = {
            "gravel.png",
            bottem_half,
            "gravel.png^[lowpart:50:" .. bottem_half,
            "gravel.png^[lowpart:50:" .. bottem_half,
            "gravel.png^[lowpart:50:" .. bottem_half,
            "gravel.png^[lowpart:50:" .. bottem_half,
        },
        groups = {crumbly = 2},
    })

end

-----------
-- Rails --
-----------

local alpha_rail_groups = carts.get_rail_groups()
alpha_rail_groups.not_in_creative_inventory = 1

carts:register_rail("cart_addon:mc_rail", {
    description = "rail",
    tiles = {
        "default_rail.png",
        "default_rail_curved.png",
        "default_rail_t_junction.png",
        "default_rail_crossing.png"
    },
	inventory_image = "default_rail.png",
	wield_image = "default_rail.png",
	groups = carts.get_rail_groups(),
}, {})

carts:register_rail("cart_addon:mc_prail", {
    description = "rail",
    tiles = {
        "mcl_minecarts_rail_golden_powered_edit.png",
        "mcl_minecarts_rail_golden_curved_powered_edit.png",
        "mcl_minecarts_rail_golden_t_junction_powered_edit.png",
        "mcl_minecarts_rail_golden_crossing_powered_edit.png"
    },
	inventory_image = "mcl_minecarts_rail_golden_powered_edit.png",
	wield_image = "mcl_minecarts_rail_golden_powered_edit.png",
	groups = carts.get_rail_groups(),
}, {acceleration = 5})

carts:register_rail("cart_addon:alpha_rail", {
    description = "alpha rail",
    tiles = {
        "carts_rail_straight_alpha.png",
        "carts_rail_curved_alpha.png",
        "carts_rail_t_junction_alpha.png",
        "carts_rail_crossing_alpha.png"
    },
    drop = {
		max_items = 1,
		items = {
			{items = {"carts:rail"}}
		}
	},
	inventory_image = "carts_rail_straight_alpha.png",
	wield_image = "carts_rail_straight_alpha.png",
    groups = alpha_rail_groups,
}, {})

carts:register_rail("cart_addon:alpha_powered_rail", {
    description = "alpha powered rail",
    tiles = {
        "carts_rail_straight_alpha.png",
        "carts_rail_curved_alpha.png",
        "carts_rail_t_junction_alpha.png",
        "carts_rail_crossing_alpha.png"
    },
    drop = {
		max_items = 1,
		items = {
			{items = {"carts:powerrail"}}
		}
	},
	inventory_image = "carts_rail_straight_alpha.png",
	wield_image = "carts_rail_straight_alpha.png",
    groups = alpha_rail_groups,
}, {acceleration = 5})

carts:register_rail("cart_addon:alpha_brake_rail", {
    description = "alpha brake rail",
    tiles = {
        "carts_rail_straight_alpha.png",
        "carts_rail_curved_alpha.png",
        "carts_rail_t_junction_alpha.png",
        "carts_rail_crossing_alpha.png"
    },
    drop = {
		max_items = 1,
		items = {
			{items = {"carts:brakerail"}}
		}
	},
	inventory_image = "carts_rail_straight_alpha.png",
	wield_image = "carts_rail_straight_alpha.png",
    groups = alpha_rail_groups,
}, {acceleration = -3})

-----------
-- Tools --
-----------

minetest.register_tool("cart_addon:rail_converter", {
    description = "rail converter",
    inventory_image = "wrench.png",
    on_use = function(itemstack, user, pointed_thing)
        if(pointed_thing.type == "node") then
            local pos = pointed_thing.under
            local name = minetest.get_node(pointed_thing.under).name

            if(name == "carts:rail") then
                minetest.swap_node(pos, {name = "cart_addon:alpha_rail"})
            elseif(name == "carts:powerrail") then
                minetest.swap_node(pos, {name = "cart_addon:alpha_powered_rail"})
            elseif(name == "carts:brakerail") then
                minetest.swap_node(pos, {name = "cart_addon:alpha_brake_rail"})
            end
        end
    end,
    on_place = function(itemstack, user, pointed_thing)
        if(pointed_thing.type == "node") then
            local pos = pointed_thing.under
            local name = minetest.get_node(pointed_thing.under).name

            if(name == "cart_addon:alpha_rail") then
                minetest.swap_node(pos, {name = "carts:rail"})
            elseif(name == "cart_addon:alpha_powered_rail") then
                minetest.swap_node(pos, {name = "carts:powerrail"})
            elseif(name == "cart_addon:alpha_brake_rail") then
                minetest.swap_node(pos, {name = "carts:brakerail"})
            end
        end
    end
})

--this mod was devolped for creative, let me know if you think this reciepe should be changed(wsor)
minetest.register_craft({
	output = "cart_addon:rail_converter",
	recipe = {
		{"carts:rail", "carts:rail", "carts:rail"},
		{"carts:brakerail", "carts:brakerail", "carts:brakerail"},
		{"carts:powerrail", "carts:powerrail", "carts:powerrail"},
	}
})