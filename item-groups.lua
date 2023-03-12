data:extend {
    {
        type = "item-group",
        name = "fowood-processing",
        order = "z",
        inventory_order = "z",
        icon = "__arborium_upgrade__/graphics/icons/treex256-provisional.png",
        icon_size = 256
    },
--production--
    {
        type = "item-subgroup",
        name = "production-buildings",
        group = "fowood-processing",
        order = "a-a"
    },
    {
        type = "item-subgroup",
        name = "production-buildings-2",
        group = "fowood-processing",
        order = "a-b"
    },
    {
        type = "item-subgroup",
        name = "production-buildings-3",
        group = "fowood-processing",
        order = "a-c"
    },
    --[[{
        type = "item-subgroup",
        name = "py-cp-buildings-mk04",
        group = "fowood-processing",
        order = "a-d"
    },
    {
        type = "item-subgroup",
        name = "py-cp-buildings-others",
        group = "fowood-processing",
        order = "a-e"
    },]]
----------------
    {
        type = "item-subgroup",
        name = "intermediate",
        group = "fowood-processing",
        order = "az1"
    },
    {
        type = "item-subgroup",
        name = "resource",
        group = "fowood-processing",
        order = "az2"
    },
}
