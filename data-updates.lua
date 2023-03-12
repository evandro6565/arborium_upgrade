conf = require "__arborium_upgrade__.config"
require("__arborium_upgrade__.functions_entites")

DIR.sprites_path = string.format("%s/%s", DIR.graphics_path, "biogarden")
--FORESTRY_BASE = get_layer("iron-forestry-base", 1, 1, false, nil, 1, 320, 320, 0, 0, 320, 320, {0,0})
FORESTRY_BASE = get_layer("hr_bio_garden_anim_trees", 20, 5, false, nil, 0.25, 256, 320, 0, 0, 256, 320, {0,0})
--FORESTRY_SHADOW = get_layer("forestry-shadow", 1, 1, true, nil, 1, 448, 320, 0, 0, 448, 320, {1.0,0})
FORESTRY_SHADOW = get_layer("hr_bio_garden_anim_shadow", 20, 5, true, nil, 0.25, 384, 320, 0, 0, 384, 320, {1.0,0})

--FORESTRY_WORKING = get_layer("forestry-working", 30, 6, false, nil, 0.25, 320, 320, 0, 0, 320, 320, {0,0}, "additive", nil, nil, nil, nil, "forward-then-backward")
FORESTRY_WORKING = get_layer("hr_bio_garden_anim_light", 10, 5, false, nil, 0.25, 256, 320, 0, 0, 256, 320, {0,0}, "additive", nil, nil, nil, nil, "forward-then-backward")

local select = { conf.cr.wpu, conf.cr.biofarm }

if select[1] then
	MULCHER_ANIMATIONS = {
		layers = 
		{
			{
				filename = conf.mode_name.."graphics/wpu/left.png",
				width = 96,
				height = 277,
				line_length = 21,
				frame_count = 130,
				shift = {-1.5, -1.328},
				animation_speed = 0.42
			},
			{
				filename = conf.mode_name.."graphics/wpu/right.png",
				width = 96,
				height = 277,
				line_length = 21,
				frame_count = 130,
				shift = {1.5, -1.328},
				animation_speed = 0.42
			}
		}
	}
	ICON = conf.mode_name.."graphics/icons/wpu_icon.png"
	ICON2 = conf.mode_name.."graphics/icons/wpu_2_icon.png"
	MULCHER_SOUND = conf.mode_name.."sound/wpu.ogg"
	COLLISION_BOX = {{-2.8, -2.8}, {2.8, 2.8}}
	SELECTION_BOX = {{-3.0, -3.0}, {3.0, 3.0}}
end
if select[2] then
	DIR.sprites_path = string.format("%s/%s", DIR.graphics_path, "biofarm")
	MULCHER_ANIMATIONS = {
		layers = {
			get_layer("bio_farm", 1, 1, false, nil, 0.25, 304, 400, 0, 0, 304, 400, {0, 0}, nil, nil, nil, nil, nil, nil, {
				hr_version = true,
				shift = {0,0},
				width = 608,
				height = 800
			}),
			get_layer("bio_farm_shadow", 1, 1, true, nil, 0.25, 400, 400, 0, 0, 400, 400, {1.0, 0}, nil, nil, nil, nil, nil, nil, {
				hr_version = true,
				shift = {0,0},
				width = 800,
				height = 800
			}),
		}
	}

	working_visualisations =
		{
			{
				animation = get_layer("bio_farm_light", 1, 1, false, nil, 0.25, 400, 400, 0, 0, 400, 400, {0,0}, "additive", nil, nil, nil, nil, "forward-then-backward", 
				{ 	
					hr_version = true,
					shift = {0,0},
					width = 800,
					height = 800
				}),
				light = { color = {0.5,1.0,0.5}, intensity = 0.5, size = 12, shift = {0,-0.25}},
			}
		}
	
	table.insert(data.raw.technology["dendrology"].effects, 
	{
		type = "unlock-recipe",
		recipe = "mulcher-2"
	})

	data.raw.technology["dendrology-2"].effects[2].recipe = "mulcher-3"

	--data.raw["furnace"]["mulcher"].working_visualisations = nil--working_visualisations
	data.raw["furnace"]["mulcher-2"].working_visualisations = working_visualisations
	data.raw["furnace"]["mulcher"].corpse = "mulcher-biofarm-remnants"
	data.raw["furnace"]["mulcher-2"].corpse = "mulcher-biofarm-remnants"
	--data.raw["furnace"]["mulcher-2"].next_upgrade = "mulcher-3"
	ICON = conf.mode_name.."graphics/icons/Bio_Farm_Icon.png"
	ICON2 = conf.mode_name.."graphics/icons/Bio_Farm_Lamp.png"
	MULCHER_SOUND = conf.mode_name.."sound/BI_sawmill.ogg"
	--COLLISION_BOX = {{-4, -4}, {4, 5.3}}
	--SELECTION_BOX = {{-4.5, -6.5}, {4.5, 5.5}}
	COLLISION_BOX = {{-2.8, -2.8}, {2.8, 2.8}}
	SELECTION_BOX = {{-3.0, -3.0}, {3.0, 3.0}}
end

arborium = {
	energy_source =
    {
		type = "void",
		emissions = -0.005,
		usage_priority = "secondary-input",
		drain = "0W", 
		emissions_per_minute = -2.5, 
    },
	corpse = "arborium-remnants",
}

if mods["Arborium_Renewed"] then
	data.raw["furnace"]["mulcher"].icon = ICON
	data.raw["furnace"]["mulcher"].icon_size = 64
	data.raw["furnace"]["mulcher"].collision_box = COLLISION_BOX
	data.raw["furnace"]["mulcher"].collision_box = SELECTION_BOX
	data.raw["furnace"]["mulcher"].animation = MULCHER_ANIMATIONS
	data.raw["furnace"]["mulcher"].working_sound =
	    {
	      sound = {
	        {
			  filename = MULCHER_SOUND,
	          volume = 1.0
	        },
	      },
	      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
	      apparent_volume = 1.5,
	    }

	data.raw["furnace"]["mulcher-2"].icon = ICON2
	data.raw["furnace"]["mulcher-2"].icon_size = 64
	data.raw["furnace"]["mulcher-2"].collision_box = COLLISION_BOX
	data.raw["furnace"]["mulcher-2"].collision_box = SELECTION_BOX
	data.raw["furnace"]["mulcher-2"].animation = MULCHER_ANIMATIONS
	data.raw["furnace"]["mulcher-2"].working_sound =
	    {
	      sound = {
	        {
			  filename = MULCHER_SOUND,
	          volume = 1.0
	        },
	      },
	      idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
	      apparent_volume = 1.5,
	    }
	
	data.raw["furnace"]["arborium"].icon = conf.mode_name.."graphics/icons/bio_garden_icon.png"
	data.raw["furnace"]["arborium"].icon_size = 64
	data.raw["furnace"]["arborium"].corpse = arborium.corpse
	data.raw["furnace"]["arborium"].energy_source = arborium.energy_source
	data.raw["furnace"]["arborium"].collision_box = {{-2.2, -1.2}, {2.2, 2.2}}
	data.raw["furnace"]["arborium"].selection_box = {{-2.5, -1.5}, {2.5, 1.5}}
	data.raw["furnace"]["arborium"].animation.layers =
		{
			FORESTRY_BASE,
			FORESTRY_SHADOW, 
		}
	data.raw["furnace"]["arborium"].working_visualisations =
		{
			{
			animation = FORESTRY_WORKING,
			light = { color = {0.5,1.0,0.5}, intensity = 0.5, size = 12, shift = {0,-0.25}},
			}
		}

	data.raw["furnace"]["arborium-2"].icon = conf.mode_name.."graphics/icons/bio_garden_2_icon.png"
	data.raw["furnace"]["arborium-2"].icon_size = 64
	data.raw["furnace"]["arborium-2"].corpse = arborium.corpse
	data.raw["furnace"]["arborium-2"].energy_source = arborium.energy_source
	data.raw["furnace"]["arborium-2"].collision_box = {{-2.2, -1.2}, {2.2, 2.2}}
	data.raw["furnace"]["arborium-2"].selection_box = {{-2.5, -1.5}, {2.5, 1.5}}
	data.raw["furnace"]["arborium-2"].animation.layers =
		{
			FORESTRY_BASE,
			FORESTRY_SHADOW, 
		}	
	data.raw["furnace"]["arborium-2"].working_visualisations =
	    {
	      {
			animation = FORESTRY_WORKING,
			light = { color = {0.5,1.0,0.5}, intensity = 0.5, size = 12, shift = {0,-0.25}},
	      }
	    }

	data.raw["furnace"]["arborium-3"].icon = conf.mode_name.."graphics/icons/bio_garden_3_icon.png"
	data.raw["furnace"]["arborium-3"].icon_size = 64
	data.raw["furnace"]["arborium-3"].corpse = arborium.corpse
	data.raw["furnace"]["arborium-3"].energy_source = arborium.energy_source
	data.raw["furnace"]["arborium-3"].collision_box = {{-2.2, -1.2}, {2.2, 2.2}}
	data.raw["furnace"]["arborium-3"].selection_box = {{-2.5, -1.5}, {2.5, 1.5}}
	data.raw["furnace"]["arborium-3"].animation.layers = 
		{
			FORESTRY_BASE,
			FORESTRY_SHADOW, 
		}	
	data.raw["furnace"]["arborium-3"].working_visualisations =
	    {
	      {
			animation = FORESTRY_WORKING,
			light = { color = {0.5,1.0,0.5}, intensity = 0.5, size = 12, shift = {0,-0.25}},
	      }
	    }
	if mods["aai-industry"] then 
		--bi_sand_stone_brick = 
		table.insert(data.raw.technology["dendrology-pack"].effects, 
		{
			type = "unlock-recipe",
			recipe = "bi-sand-stone-brick"
		})
		--crushed_stone_to_sand = 
		table.insert(data.raw.technology["dendrology-pack"].effects, 
		{
			type = "unlock-recipe",
			recipe = "crushed-stone-to-sand"
		})

		data.raw["recipe"]["arborium"].ingredients =
	    {
	      {"wood", 10},
		  {"iron-plate", 10},
		  {"glass", 10}
	    }

	    data.raw["recipe"]["arborium-2"].ingredients =
	    {
	      {"wood", 25},
		  {"steel-plate", 15},
		  {"copper-cable", 5},
		  {"glass", 10},
	      {"arborium", 1}
	    }

	    data.raw["recipe"]["arborium-3"].ingredients =
	    {
	      {"wood", 50},
		  {"steel-plate", 10},
		  {"copper-cable", 15},
		  {"plastic-bar", 10},
		  {"glass", 20},
	      {"arborium-2", 1}
	    }
	end

	data.raw.technology["dendrology"].icon = conf.mode_name.."graphics/icons/treex256-provisional.png"
	data.raw.technology["dendrology"].icon_size = 256

	data.raw.technology["dendrology-2"].icon = conf.mode_name.."graphics/icons/treex256-provisional.png"
	data.raw.technology["dendrology-2"].icon_size = 256

	data.raw.item["mulcher"].icon = ICON
	data.raw.item["mulcher"].icon_size = 64
	data.raw.item["mulcher"].subgroup = "production-buildings"
	data.raw.item["mulcher"].order = "a-a[mulcher]"

	data.raw.item["mulcher-2"].icon = ICON2
	data.raw.item["mulcher-2"].icon_size = 64
	data.raw.item["mulcher-2"].subgroup = "production-buildings-2"
	data.raw.item["mulcher-2"].order = "a-a[mulcher-2]"

	data.raw.item["arborium"].icon = conf.mode_name.."graphics/icons/bio_garden_icon.png"
	data.raw.item["arborium"].icon_size = 64
	data.raw.item["arborium"].subgroup = "production-buildings"
	data.raw.item["arborium"].order = "a-a[arborium]"

	data.raw.item["arborium-2"].icon = conf.mode_name.."graphics/icons/bio_garden_2_icon.png"
	data.raw.item["arborium-2"].icon_size = 64
	data.raw.item["arborium-2"].subgroup = "production-buildings-2"
	data.raw.item["arborium-2"].order = "a-a[arborium-2]"

	data.raw.item["arborium-3"].icon = conf.mode_name.."graphics/icons/bio_garden_3_icon.png"
	data.raw.item["arborium-3"].icon_size = 64
	data.raw.item["arborium-3"].subgroup = "production-buildings-3"
	data.raw.item["arborium-3"].order = "a-a[arborium-3]"

	data.raw.recipe["mulcher"].icon = ICON
	data.raw.recipe["mulcher"].icon_size = 64
	data.raw.recipe["mulcher"].subgroup = "production-buildings"
	data.raw.recipe["mulcher"].order = "a-a[mulcher]"

	data.raw.recipe["mulcher-2"].icon = ICON2
	data.raw.recipe["mulcher-2"].icon_size = 64
	data.raw.recipe["mulcher-2"].subgroup = "production-buildings-2"
	data.raw.recipe["mulcher-2"].order = "a-a[mulcher-2]"
	data.raw.recipe["mulcher-2"].ingredients = 
	{
		{"mulcher", 1},
		{"electronic-circuit", 2},
		{"small-lamp", 1},
		{"steel-plate", 5}
	}

	data.raw.recipe["arborium"].icon = conf.mode_name.."graphics/icons/bio_garden_icon.png"
	data.raw.recipe["arborium"].icon_size = 64
	data.raw.recipe["arborium"].subgroup = "production-buildings"
	data.raw.recipe["arborium"].order = "a-a[arborium]"

	data.raw.recipe["arborium-2"].icon = conf.mode_name.."graphics/icons/bio_garden_2_icon.png"
	data.raw.recipe["arborium-2"].icon_size = 64
	data.raw.recipe["arborium-2"].subgroup = "production-buildings-2"
	data.raw.recipe["arborium-2"].order = "a-a[arborium-2]"

	data.raw.recipe["arborium-3"].icon = conf.mode_name.."graphics/icons/bio_garden_3_icon.png"
	data.raw.recipe["arborium-3"].icon_size = 64
	data.raw.recipe["arborium-3"].subgroup = "production-buildings-3"
	data.raw.recipe["arborium-3"].order = "a-a[arborium-3]"
end