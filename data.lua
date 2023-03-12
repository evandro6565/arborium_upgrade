local hit_effects = require ("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")
conf = require "__arborium_upgrade__.config"
require("__arborium_upgrade__.functions_entites")

require "technology"
require "item-groups"
require "recipe-categories"

op = { conf.cr.stone_crusher, conf.cr.jaw }

cokery_charcoal_recipe = {
  type = "recipe",
  name = "charcoal-raw-wood",
  icon = conf.mode_name.."graphics/icons/charcoal_raw-wood.png",
  icon_size = 64,
  subgroup = "resource",
  order = "a-a[charcoal-raw-wood]",
  category = "crafting-cokery",
  enabled = false,
  energy_required = 7,
  ingredients =
  {
    {"wood", 2},
  },
  result = "coal"
}
cokery_ash_raw_wood_recipe = {
  type = "recipe",
  name = "ash-raw-wood",
  icon = conf.mode_name.."graphics/icons/py_ash_raw-wood.png",
  icon_size = 64,
  subgroup = "resource",
  order = "a-a[ash-raw-wood]",
  category = "crafting-cokery",
  energy_required = 5,
  enabled = false,
  ingredients =
  {
    {"wood", 1},
  },
  results = {{ type = "item", name = "cokery-ash", amount = 5 }}
}
cokery_ash_coal_recipe = {
  type = "recipe",
  name = "ash-coal",
  icon = conf.mode_name.."graphics/icons/py_ash_coal.png",
  icon_size = 64,
  subgroup = "resource",
  order = "a-a[ash-coal]",
  category = "crafting-cokery",
  enabled = false,
  energy_required = 2,
  ingredients =
  {
    {"coal", 1},
  },
  results = {{ type = "item", name = "cokery-ash", amount = 10 }}
}
cokery_bake_raw_brick_recipe = {
  type = "recipe",
  name = "bake-raw-brick",
  icon = conf.mode_name.."graphics/icons/bake_raw_brick.png",
  icon_size = 64,
  subgroup = "resource",
  order = "a-a[ash-raw-wood]",
  category = "crafting-cokery",
  energy_required = 7,
  enabled = false,
  ingredients =
  {
    {"raw-brick", 10},
  },
  results = {{ type = "item", name = "stone-brick", amount = 10 }}
}

crushed_stone_brick_recipe = {
  type = "recipe",
  name = "bi-stone-brick",
  icon = conf.mode_name.."graphics/icons/py_bi_stone_brick.png",
  icon_size = 64,
  subgroup = "intermediate",
  order = "a-a[bi-stone-brick]",
  category = "crafting-with-fluid",
  enabled = false,
  energy_required = 7,
  ingredients =
  {
    { type = "fluid", name = "water", amount = 100 },
    {"cokery-ash", 20},
    {"crushed-stone", 5}
  },
  results = {{ type = "item", name = "raw-brick", amount = 10 }}
}

crushed_stone_rail_recipe = util.table.deepcopy(data.raw.recipe["rail"])
crushed_stone_rail_recipe.name = "rail-crushed-stone"
crushed_stone_rail_recipe.ingredients =
    {
      {"crushed-stone", 5},
      {"iron-stick", 1},
      {"steel-plate", 1}
    }

if mods["aai-industry"] then
  crushed_stone_brick_recipe_2 = 
  {
    type = "recipe",
    name = "bi-sand-stone-brick",
    icon = conf.mode_name.."graphics/icons/py_bi_sand_stone_brick.png",
    icon_size = 64,
    subgroup = "intermediate",
    order = "a-a[bi-sand-stone-brick]",
    category = "crafting-with-fluid",
    enabled = false,
    energy_required = 7,
    ingredients =
    {
      { type = "fluid", name = "water", amount = 100 },
      {"cokery-ash", 20},
      {"sand", 20}
    },
    results = {{ type = "item", name = "raw-brick", amount = 10 }}
  }
  crushed_stone_to_sand_recipe = {
    type = "recipe",
    name = "crushed-stone-to-sand",
    icon = conf.mode_name.."graphics/icons/crushed_stone_to_sand.png",
    icon_size = 64,
    subgroup = "intermediate",
    order = "a-a[crushed-stone-to-sand]",
    category = "crafting",
    enabled = false,
    energy_required = 1,
    ingredients =
    {
      {"crushed-stone", 5}
    },
    results = {{ type = "item", name = "sand", amount = 10 }}
  }
  data:extend { crushed_stone_to_sand_recipe, crushed_stone_brick_recipe_2 }
end

data:extend { cokery_charcoal_recipe, cokery_ash_raw_wood_recipe, cokery_ash_coal_recipe, crushed_stone_brick_recipe,cokery_bake_raw_brick_recipe, crushed_stone_rail_recipe }

cokery_ash_item = {
  type = "item",
  name = "cokery-ash",
  icon = conf.mode_name.."graphics/icons/ash.png",
  icon_size = 64,
  --mipmap_count = 4, 
  pictures =
  {
    { size = 64, filename = conf.mode_name.."graphics/icons/ash.png",   scale = 0.25 },
  },
  fuel_category = "chemical",
  fuel_value = "4MJ",
  subgroup = "resource",
  order = "a-a[cokery-ash]",
  stack_size = 50
}
crushed_stone_item = {
  type = "item",
  name = "crushed-stone",
  icon = conf.mode_name.."graphics/icons/crushed-stone-stone.png",
  icon_size = 64,
  subgroup = "resource",
  order = "a-a[crushed-stone]",
  --place_result = "cokery-pl",
  stack_size = 50
}
raw_brick = {
  type = "item",
  name = "raw-brick",
  icon = conf.mode_name.."graphics/icons/raw-brick.png",
  icon_size = 64,
  subgroup = "resource",
  order = "a-a[raw-brick]",
  stack_size = 100
}

data:extend {crushed_stone_item, cokery_ash_item,raw_brick}

cokery_item = {
  type = "item",
  name = "cokery-pl",
  icon = conf.mode_name.."graphics/icons/cokery.png",
  icon_size = 64,
  subgroup = "production-buildings",
  order = "a-a[cokery-pl]",
  place_result = "cokery-pl",
  stack_size = 10
}

cokery_recipe = {
  type = "recipe",
  name = "cokery-pl",
  enabled = false,
  energy_required = 5,
  subgroup = "production-buildings",
  order = "a-a[cokery-pl]",
  ingredients =
  {
    {"steel-plate", 5},
    {"copper-plate", 5},
    {"iron-gear-wheel", 10},
    {"stone-brick", 10},
  },
  result = "cokery-pl"
}

cokery_entity =
{
  type = "assembling-machine",
  name = "cokery-pl",
  icon = conf.mode_name.."graphics/icons/cokery.png",
  icon_size = 64,
  flags = {"placeable-neutral", "placeable-player", "player-creation", "not-rotatable"},
  minable = {mining_time = 0.2, result = "cokery-pl"},
  max_health = 350,
  --rotatable = false,
  corpse = "cokery-pl-remnants",
  dying_explosion = "assembling-machine-2-explosion",
  alert_icon_shift = util.by_pixel(0.4, -4.5),
  resistances =
  {
    {
      type = "fire",
      percent = 90
    }
  },
  collision_box = {{-1.4, -0.2}, {1.4, 1.2}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  damaged_trigger_effect = hit_effects.entity(),
  fast_replaceable_group = "cokery-pl",
  --next_upgrade = "assembling-machine-3",
  animation =
  {
    layers =
    {
      {
        filename = conf.mode_name.."graphics/cokery/cokery_anim.png",
        priority = "high",
        width = 128,
        height = 128,
        frame_count = 16,
        line_length = 8,
        animation_speed = 0.2,
        shift = util.by_pixel(15.4, -16.4),
        hr_version =
        {
          filename = conf.mode_name.."graphics/cokery/hr_cokery_anim.png",
          priority = "high",
          width = 256,
          height = 256,
          frame_count = 16,
          line_length = 8,
          animation_speed = 0.2,
          shift = util.by_pixel(15.8, -15.3),
          scale = 0.5
        }
      },
      {
        filename = conf.mode_name.."graphics/cokery/cokery_anim_shadow.png",
        priority = "high",
        width = 167,
        height = 64,
        frame_count = 16,
        line_length = 8,
        draw_as_shadow = true,
        shift = util.by_pixel(17.2, 18.9),
        hr_version =
        {
          filename = conf.mode_name.."graphics/cokery/hr_cokery_anim_shadow.png",
          priority = "high",
          width = 334,
          height = 128,
          frame_count = 16,
          line_length = 8,
          draw_as_shadow = true,
          shift = util.by_pixel(14.8, 20),
          scale = 0.5
        }
      }
    }
  },
  open_sound = sounds.machine_open,
  close_sound = sounds.machine_close,
  vehicle_impact_sound = sounds.generic_impact,
  working_sound =
  {
    sound =
    {
      {
        filename = "__base__/sound/steel-furnace.ogg",
        volume = 0.46
      }
    },
    max_sounds_per_type = 4,
    audible_distance_modifier = 0.37,
    fade_in_ticks = 4,
    fade_out_ticks = 20
  },
  crafting_categories = {"crafting-cokery"},

  crafting_speed = 0.75,
  energy_source = {
    type = "burner",
    fuel_categories = {"chemical", data.raw["fuel-category"]["processed-chemical"] and "processed-chemical"},
    effectivity = 0.9,
    fuel_inventory_size = 1,
    emissions_per_minute = 4,
    light_flicker =
    {
      minimum_light_size = 1,
      light_intensity_to_size_coefficient = 0.2,
      color = {1,0.6,0},
      minimum_intensity = 0.05,
      maximum_intensity = 0.2
    },
    smoke =
    {
      {
        name = "smoke",
        deviation = {0.1, 0.1},
        position = {-0.5, -1.87},
        frequency = 3
      },
      {
        name = "smoke",
        deviation = {0.1, 0.1},
        position = {0.14, -1.87},
        frequency = 3
      },
      {
        name = "smoke",
        deviation = {0.1, 0.1},
        position = {0.77, -1.87},
        frequency = 3
      },
    }
  },
  energy_usage = "150kW",
  module_specification =
  {
    module_slots = 1
  },
  allowed_effects = {"productivity"}
}

data:extend {cokery_item, cokery_recipe, cokery_entity}

if op[1] then
  quarry_recipe = {
    type = "recipe",
    name = "quarry",
    enabled = false,
    energy_required = 5,
    ingredients =
    {
      {"steel-plate", 5},
      {"copper-plate", 5},
      {"iron-gear-wheel", 10},
    },
    result = "quarry"
  }

  quarry_item = {
    type = "item",
    name = "quarry",
    icon = conf.mode_name.."graphics/icons/quarry_cr.png",
    icon_size = 64,
    subgroup = "production-buildings",
    order = "a-a[quarry]",
    place_result = "quarry",
    stack_size = 10
  }

  quarry = 
  {
    type = "assembling-machine",
    name = "quarry",
    icon = conf.mode_name.."graphics/icons/quarry_cr.png",
    icon_size = 64,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "quarry"},
    max_health = 300,
    corpse = "quarry-remnants",
    dying_explosion = "assembling-machine-1-explosion",
    resistances =
    {
      {
        type = "fire",
        percent = 70
      }
    },
    collision_box = {{-0.8, -0.8}, {0.8, 0.4}},
    selection_box = {{-1, -1.5}, {0.9, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    fast_replaceable_group = "quarry",
    --next_upgrade = "assembling-machine-2",
    alert_icon_shift = util.by_pixel(-2.1, -38.6),
    idle_animation =
    {
      layers =
      {
        {
          filename = conf.mode_name.."graphics/quarry/stone_crusher_off.png",
          priority = "high",
          line_length = 1,
          width = 65,
          height = 78,
          frame_count = 1,
          repeat_count = 20, -- up
          shift = util.by_pixel(-2.7, -19.8),
          hr_version =
          {
            filename = conf.mode_name.."graphics/quarry/hr_stone_crusher_off.png",
            priority = "high",
            scale = 0.5,
            line_length = 1,
            repeat_count = 20, -- up
            width = 130,
            height = 156,
            frame_count = 1,
            shift = util.by_pixel(-2, -18.6)
          }
        },
        {
          filename = conf.mode_name.."graphics/quarry/stone_crusher_shadow.png",
          draw_as_shadow = true,
          priority = "high",
          line_length = 1,
          width = 98,
          height = 78,
          repeat_count = 20, -- up
          frame_count = 1,
          shift = util.by_pixel(14.8, -15.1),
          hr_version =
          {
            filename = conf.mode_name.."graphics/quarry/hr_stone_crusher_shadow.png",
            draw_as_shadow = true,
            priority = "high",
            scale = 0.5,
            line_length = 1,
            repeat_count = 20, -- up
            width = 196,
            height = 156,
            frame_count = 1,
            shift = util.by_pixel(14.4, -14.6)
          }
        },
      }
    },
    animation =
    {
      layers =
      {
        {
          filename = conf.mode_name.."graphics/quarry/stone_crusher_anim.png",
          priority="high",
          width = 65,
          height = 78,
          frame_count = 20,
          line_length = 10,
          shift = util.by_pixel(-2.7, -19.8),
          hr_version =
          {
            filename = conf.mode_name.."graphics/quarry/hr_stone_crusher_anim.png",
            priority="high",
            width = 130,
            height = 156,
            frame_count = 20,
            line_length = 10,
            shift = util.by_pixel(-2, -18.6),
            scale = 0.5
          }
        },
        {
          filename = conf.mode_name.."graphics/quarry/stone_crusher_shadow.png",
          priority="high",
          width = 98,
          height = 78,
          frame_count = 1,
          line_length = 1,
          repeat_count = 20,
          draw_as_shadow = true,
          shift = util.by_pixel(14.8, -15.1),
          hr_version =
          {
            filename = conf.mode_name.."graphics/quarry/hr_stone_crusher_shadow.png",
            priority="high",
            width = 196,
            height = 156,
            frame_count = 1,
            line_length = 1,
            repeat_count = 20,
            draw_as_shadow = true,
            shift = util.by_pixel(14.4, -14.6),
            scale = 0.5
          }
        }
      }
    },
    fixed_recipe = "recipe-stone-processing",
    crafting_categories = {"stone-processing"},
    crafting_speed = 0.5,
    energy_source =
    {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = 4
    },
    energy_usage = "75kW",
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    vehicle_impact_sound = sounds.generic_impact,
    working_sound =
    {
      sound =
      {
        {
          filename = conf.mode_name.."sound/BI_stonecrusher.ogg",
          volume = 0.5
        }
      },
      audible_distance_modifier = 0.5,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    }
  }
end
if op[2] then
  if mods["aai-industry"] then 
    ing = {"motor", 4}
  else
    ing = {"steam-engine", 4}
  end
  quarry_recipe = {
    type = "recipe",
    name = "quarry", --"jaw-crusher",
    energy_required = 7,
    enabled = false,
    ingredients = {
        {"iron-plate", 25},
        ing,
        {"steel-plate", 30},
        {"electronic-circuit", 15}
    },
    results = {
        {"quarry", 1}
    }
  }

  quarry_item = {
    type = "item",
    name = "quarry",
    icon = conf.mode_name.."graphics/icons/quarry.png",
    icon_size = 64,
    flags = {},
    subgroup = "production-buildings",
    order = "a-a[quarry]",
    place_result = "quarry",
    stack_size = 10
  }

  quarry = {
    type = "assembling-machine",
    name = "quarry", --"jaw-crusher",
    icon = conf.mode_name.."graphics/icons/quarry.png",
    icon_size = 64,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 1, result = "quarry"},
    fast_replaceable_group = "quarry",
    max_health = 600,
    corpse = "medium-remnants",
    dying_explosion = "medium-explosion",
    collision_box = {{-3.3, -3.3}, {3.3, 3.3}},
    selection_box = {{-3.5, -3.5}, {3.5, 3.5}},
    match_animation_speed_to_activity = false,
    module_specification = {
        module_slots = 1
    },
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    fixed_recipe = "recipe-stone-processing",
    crafting_categories = {"stone-processing"},
    crafting_speed = 1,
    energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        emissions_per_minute = 0.06,
    },
    energy_usage = "550kW",--"1MW",
    animation = {
        layers = {
            {
                filename = conf.mode_name.."graphics/jaw/sprite-left.png",
                width = 96,
                height = 256,
                line_length = 21,
                frame_count = 161,
                shift = {-2.0, -0.5},
                animation_speed = 0.5
            },
            {
                filename = conf.mode_name.."graphics/jaw/sprite-mid.png",
                width = 96,
                height = 256,
                line_length = 21,
                frame_count = 161,
                shift = {1.0, -0.5},
                animation_speed = 0.5
            },
            {
                filename = conf.mode_name.."graphics/jaw/sprite-right.png",
                width = 32,
                height = 256,
                line_length = 64,
                frame_count = 161,
                shift = {3.0, -0.5},
                animation_speed = 0.5
            }
        }
    },
    vehicle_impact_sound = {filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65},
    working_sound = {
        sound = {filename = conf.mode_name.."sound/classifier.ogg", volume = 0.85},
        idle_sound = {filename = conf.mode_name.."sound/classifier.ogg", volume = 0.3},
        apparent_volume = 2.5
    }
  }
end

quarry_l2 = util.table.deepcopy(quarry)
quarry_l2.name = "quarry-l2"
quarry_l2.fixed_recipe = "recipe-stone-processing-l2"
quarry_l2.placeable_by = {item = "quarry", count = 1}

quarry_l3 = util.table.deepcopy(quarry)
quarry_l3.name = "quarry-l3"
quarry_l3.fixed_recipe = "recipe-stone-processing-l3"
quarry_l3.placeable_by = {item = "quarry", count = 1}

quarry_l4 = util.table.deepcopy(quarry)
quarry_l4.name = "quarry-l4"
quarry_l4.fixed_recipe = "recipe-stone-processing-l4"
quarry_l4.placeable_by = {item = "quarry", count = 1}

if mods["space-exploration"] then
  quarry_sp_l2 = util.table.deepcopy(quarry)
  quarry_sp_l2.name = "quarry-sp-l2"
  quarry_sp_l2.fixed_recipe = "recipe-stone-processing-sp-l2"
  quarry_sp_l2.placeable_by = {item = "quarry", count = 1}

  quarry_sp_l3 = util.table.deepcopy(quarry)
  quarry_sp_l3.name = "quarry-sp-l3"
  quarry_sp_l3.fixed_recipe = "recipe-stone-processing-sp-l3"
  quarry_sp_l3.placeable_by = {item = "quarry", count = 1}

  quarry_sp_l4 = util.table.deepcopy(quarry)
  quarry_sp_l4.name = "quarry-sp-l4"
  quarry_sp_l4.fixed_recipe = "recipe-stone-processing-sp-l4"
  quarry_sp_l4.placeable_by = {item = "quarry", count = 1}
  data:extend {quarry_sp_l2,quarry_sp_l3,quarry_sp_l4}
end

stone_processing_recipe_l1 = {
  type = "recipe",
  name = "recipe-stone-processing",
  icon = conf.mode_name.."graphics/icons/stone-process.png",
  icon_size = 64,
  energy_required = 30,
  subgroup = "production-buildings",
  order = "a-a[recipe-stone-processing]",
  category = "stone-processing",
  enabled = false,
  hidden = true,
  ingredients = {},
  results = 
  {
      {type = "item", name = "crushed-stone", amount = 5, probability=0.2, hide_from_stats=false},	
      {type = "item", name = "stone", amount = 1, probability=0.1, hide_from_stats=false},
  }
}
stone_processing_recipe_l2 = util.table.deepcopy(stone_processing_recipe_l1)
stone_processing_recipe_l2.icon = conf.mode_name.."graphics/icons/stone-process-up.png"
stone_processing_recipe_l2.name = "recipe-stone-processing-l2"
stone_processing_recipe_l2.order = "a-a[recipe-stone-processing-l2]"
stone_processing_recipe_l2.enabled = true
stone_processing_recipe_l2.results = 
  {
      {type = "item", name = "crushed-stone", amount = 7, probability=2, hide_from_stats=false},	
      {type = "item", name = "stone", amount = 5, probability=0.9, hide_from_stats=false},
  }
stone_processing_recipe_l3 = util.table.deepcopy(stone_processing_recipe_l2)
stone_processing_recipe_l3.name = "recipe-stone-processing-l3"
stone_processing_recipe_l3.order = "a-a[recipe-stone-processing-l3]"
stone_processing_recipe_l3.results =
  {
      {type = "item", name = "crushed-stone", amount = 10, probability=3, hide_from_stats=false},	
      {type = "item", name = "stone", amount = 8, probability=2, hide_from_stats=false},
      {type = "item", name = "coal", amount = 5, probability=0.9, hide_from_stats=false},
  }
stone_processing_recipe_l4 = util.table.deepcopy(stone_processing_recipe_l2)
stone_processing_recipe_l4.name = "recipe-stone-processing-l4"
stone_processing_recipe_l4.order = "a-a[recipe-stone-processing-l4]"
stone_processing_recipe_l4.results =
  {
      {type = "item", name = "crushed-stone", amount = 15, probability=3, hide_from_stats=false},	
      {type = "item", name = "stone", amount = 12, probability=2, hide_from_stats=false},
      {type = "item", name = "coal", amount = 10, probability=1, hide_from_stats=false},
      {type = "item", name = "iron-ore", amount = 1, probability=0.5, hide_from_stats=false},
      {type = "item", name = "copper-ore", amount = 1, probability=0.09, hide_from_stats=false},
  }

if mods["space-exploration"] then
  stone_processing_recipe_sp_l2 = util.table.deepcopy(stone_processing_recipe_l2)
  stone_processing_recipe_sp_l2.name = "recipe-stone-processing-sp-l2"
  stone_processing_recipe_sp_l2.results = 
  {
      {type = "item", name = "crushed-stone", amount = 7, probability=2, hide_from_stats=false},	
      {type = "item", name = "stone", amount = 5, probability=0.9, hide_from_stats=false},
      {type = "item", name = "iron-ore", amount = 1, probability=0.4, hide_from_stats=false},
      {type = "item", name = "copper-ore", amount = 1, probability=0.09, hide_from_stats=false},
      {type = "item", name = "uranium-ore", amount = 1, probability=0.1, hide_from_stats=false},
  }
  stone_processing_recipe_sp_l3 = util.table.deepcopy(stone_processing_recipe_l2)
  stone_processing_recipe_sp_l3.name = "recipe-stone-processing-sp-l3"
  stone_processing_recipe_sp_l3.results =
  {
      {type = "item", name = "crushed-stone", amount = 10, probability=3, hide_from_stats=false},	
      {type = "item", name = "stone", amount = 8, probability=2, hide_from_stats=false},
      {type = "item", name = "coal", amount = 5, probability=0.9, hide_from_stats=false},
      {type = "item", name = "iron-ore", amount = 1, probability=0.5, hide_from_stats=false},
      {type = "item", name = "copper-ore", amount = 1, probability=0.1, hide_from_stats=false},
      {type = "item", name = "uranium-ore", amount = 1, probability=0.2, hide_from_stats=false},
  }
  stone_processing_recipe_sp_l4 = util.table.deepcopy(stone_processing_recipe_l2)
  stone_processing_recipe_sp_l4.name = "recipe-stone-processing-sp-l4"
  stone_processing_recipe_sp_l4.results =
  {
      {type = "item", name = "crushed-stone", amount = 15, probability=3, hide_from_stats=false},	
      {type = "item", name = "stone", amount = 11, probability=2, hide_from_stats=false},
      {type = "item", name = "coal", amount = 10, probability=1, hide_from_stats=false},
      {type = "item", name = "iron-ore", amount = 1, probability=0.7, hide_from_stats=false},
      {type = "item", name = "copper-ore", amount = 1, probability=0.2, hide_from_stats=false},
      {type = "item", name = "uranium-ore", amount = 1, probability=0.3, hide_from_stats=false},
  }
  data:extend {stone_processing_recipe_sp_l2, stone_processing_recipe_sp_l3, stone_processing_recipe_sp_l4}
end

data:extend {quarry_recipe, quarry_item, quarry, quarry_l2, quarry_l3, quarry_l4, stone_processing_recipe_l1, stone_processing_recipe_l2, stone_processing_recipe_l3, stone_processing_recipe_l4}

mulcher_3 = util.table.deepcopy(data.raw["furnace"]["mulcher-2"])
mulcher_3.name = "mulcher-3"
mulcher_3.icon = conf.mode_name.."graphics/icons/Bio_Farm_Solar.png"
mulcher_3.minable.result = "mulcher-3"
mulcher_3.corpse = "mulcher-biofarm-remnants"
--mulcher_3.order = "a-a[mulcher-3]"
mulcher_3.fast_replaceable_group = "arbor-mulch"
--mulcher_3.next_upgrade = "mulcher-2"
mulcher_3.max_health = 800
mulcher_3.energy_source =
  {
    type = "void",
    emissions = -0.005,
    usage_priority = "secondary-input",
    drain = "0W", 
    emissions_per_minute = -2.5, 
  }

mulcher_3_item = util.table.deepcopy(data.raw.item["mulcher-2"])
mulcher_3_item.icon = conf.mode_name.."graphics/icons/Bio_Farm_Solar.png"
mulcher_3_item.name = "mulcher-3"
mulcher_3_item.order = "a-a[mulcher-3]"
mulcher_3_item.subgroup = "production-buildings-3"
mulcher_3_item.place_result = "mulcher-3"

mulcher_3_recipe = util.table.deepcopy(data.raw.recipe["mulcher-2"])
mulcher_3_recipe.name = "mulcher-3"
mulcher_3_recipe.order = "a-a[mulcher-3]"
mulcher_3_recipe.subgroup = "production-buildings-3"
mulcher_3_recipe.icon = conf.mode_name.."graphics/icons/Bio_Farm_Solar.png"
mulcher_3_recipe.icon_size = 64
mulcher_3_recipe.ingredients =
    {
      {"mulcher-2", 1},
      {"solar-panel", 1},
      {"advanced-circuit", 2},
    }
mulcher_3_recipe.result="mulcher-3"

if conf.cr.biofarm then
  data:extend {mulcher_3, mulcher_3_item, mulcher_3_recipe}

  data:extend {
    {
      type = "corpse",
      name = "mulcher-biofarm-remnants",
      icon = "__base__/graphics/icons/remnants.png",
      icon_size = 64, icon_mipmaps = 4,
      flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
      --subgroup = "storage-remnants",
      order = "a-d-b",
      selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
      tile_width = 3,
      tile_height = 3,
      selectable_in_game = false,
      time_before_removed = 60 * 60 * 15, -- 15 minutes
      final_render_layer = "remnants",
      remove_on_tile_placement = false,
      animation =
      {
        filename = conf.mode_name.."graphics/biofarm/remnants/bio_farm_remnant.png",
        line_length = 1,
        width = 364,
        height = 400,
        frame_count = 1,
        direction_count = 1,
        shift = offset({0, 0}, shift_calc( 0, 0, 364, 400, 364, 400)),--util.by_pixel(8.5, 0),
        hr_version = {
          filename = conf.mode_name.."graphics/biofarm/remnants/hr_bio_farm_remnant.png",
          line_length = 1,
          width = 728,
          height = 800,
          frame_count = 1,
          direction_count = 1,
          shift = offset({0, 0}, shift_calc( 0, 0, 728, 800, 728, 800)),--util.by_pixel(8.5, 0),
          scale = 0.5
        }
      }
    },
  }
end

if mods["StoneToOre"] then
  ing_add = "crushed-stone"

  iron_ore = util.table.deepcopy(data.raw.recipe["Iron Ore"])
  iron_ore.name = "Iron Ore up"
  iron_ore.ingredients =
  {
    {type="item", name=ing_add, amount=25},
    {type="fluid", name="steam", amount=50}
  }
  
  copper_ore = util.table.deepcopy(data.raw.recipe["copper Ore"])
  copper_ore.name = "copper Ore up"
  copper_ore.ingredients =
  {
    {type="item", name=ing_add, amount=25},
    {type="fluid", name="steam", amount=50}
  }

  uran_ore = util.table.deepcopy(data.raw.recipe["uran Ore"])
  uran_ore.name = "uran Ore up"
  uran_ore.energy_required = 12
  uran_ore.ingredients =
  {
    {type="item", name=ing_add, amount=70},
    {type="fluid", name="steam", amount=50}
  }
  
  coal_ore = util.table.deepcopy(data.raw.recipe["coal Ore"])
  coal_ore.name = "coal Ore up"
  coal_ore.ingredients =
  {
    {type="item", name=ing_add, amount=20},
    {type="fluid", name="steam", amount=50}
  }

  
  data:extend {iron_ore, copper_ore, uran_ore, coal_ore}
end

-- corpse
data:extend({
  {
    type = "corpse",
    name = "cokery-pl-remnants",
    icon = "__base__/graphics/icons/remnants.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    --subgroup = "storage-remnants",
    order = "a-d-b",
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    tile_width = 3,
    tile_height = 3,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation =
    {
      filename = conf.mode_name.."graphics/cokery/remnants/cokery_remnant.png",
      line_length = 1,
      width = 128,
      height = 128,
      frame_count = 1,
      direction_count = 1,
      shift = util.by_pixel(8.5, 0),
      hr_version = {
        filename = conf.mode_name.."graphics/cokery/remnants/hr_cokery_remnant.png",
        line_length = 1,
        width = 256,
        height = 256,
        frame_count = 1,
        direction_count = 1,
        shift = util.by_pixel(8.5, 0),
        scale = 0.5
      }
    }
  },
  {
    type = "corpse",
    name = "arborium-remnants",
    icon = "__base__/graphics/icons/remnants.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    --subgroup = "storage-remnants",
    order = "a-d-b",
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    tile_width = 3,
    tile_height = 3,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation =
    {
      filename = conf.mode_name.."graphics/biogarden/remnants/hr_bio_garden_remnant.png",
      line_length = 1,
      width = 128,
      height = 128,
      frame_count = 1,
      direction_count = 1,
      shift = offset({0, 0}, shift_calc( 0, 0, 128, 128, 128, 128)),--util.by_pixel(8.5, 0),
      scale = 0.5
    }
  },
  {
    type = "corpse",
    name = "quarry-remnants",
    icon = "__base__/graphics/icons/remnants.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "building-direction-8-way", "not-on-map"},
    --subgroup = "storage-remnants",
    order = "a-d-b",
    selection_box = {{-1, -1.5}, {0.9, 0.5}},
    tile_width = 3,
    tile_height = 3,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation =
    {
      filename = conf.mode_name.."graphics/quarry/remnants/stone_crusher_remnant.png",
      line_length = 1,
      width = 65,
      height = 78,
      frame_count = 1,
      direction_count = 1,
      shift = util.by_pixel(-3.5, -15.1),
      hr_version = {
        filename = conf.mode_name.."graphics/quarry/remnants/hr_stone_crusher_remnant.png",
        line_length = 1,
        width = 130,
        height = 156,
        frame_count = 1,
        direction_count = 1,
        shift = util.by_pixel(-2.6, -17.9),
        scale = 0.5
      }
    }
  },

})