conf = require "__arborium_upgrade__.config"

dendrology_pack = {
  type = "technology",
  name = "dendrology-pack",--Dendrology
  icon = conf.mode_name.."graphics/icons/treex256-provisional.png",
  icon_size = 256,
  effects =
  {
    {
      type = "unlock-recipe",
      recipe = "charcoal-raw-wood"
    },
    {
      type = "unlock-recipe",
      recipe = "ash-raw-wood"
    },
    {
      type = "unlock-recipe",
      recipe = "ash-coal"
    },
    {
      type = "unlock-recipe",
      recipe = "bi-stone-brick"
    },
    --bi_sand_stone_brick, -- aai-industry
    --crushed_stone_to_sand, -- aai-industry
    {
      type = "unlock-recipe",
      recipe = "bake-raw-brick"
    },
    {
      type = "unlock-recipe",
      recipe = "cokery-pl"
    },
    {
      type = "unlock-recipe",
      recipe = "quarry"
    },
    {
      type = "unlock-recipe",
      recipe = "rail-crushed-stone"
    },
    {
      type = "unlock-recipe",
      recipe = "recipe-stone-processing"
    },
  },
  unit =
  {
    count = 20,
    ingredients = {
      {"automation-science-pack", 1},
    },
    time = 10
  },
}

--local bi_sand_stone_brick, crushed_stone_to_sand

data:extend({
  dendrology_pack,
  {
    type = "technology",
    name = "quarry-deep-excavation-up1",--Dendrology
    icon = conf.mode_name.."graphics/icons/deep.png",
    icon_size = 256,
    prerequisites = {"dendrology-pack"},
    effects =
    {

    },
    unit =
    {
      count = 20,
      ingredients = {
        {"automation-science-pack", 1},
      },
      time = 10
    },
    upgrade = true
  },
  {
    type = "technology",
    name = "quarry-deep-excavation-up2",--Dendrology
    icon = conf.mode_name.."graphics/icons/deep.png",
    icon_size = 256,
    prerequisites = {"quarry-deep-excavation-up1"},
    effects =
    {

    },
    unit =
    {
      count = 30,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
      },
      time =20
    },
    upgrade = true
  }
})
