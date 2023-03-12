conf = require "__arborium_upgrade__.config"
if conf.cr.biofarm then
    mul_2 = data.raw["furnace"]["mulcher-2"]

    data.raw["furnace"]["mulcher-3"].working_visualisations = mul_2.working_visualisations
    data.raw["furnace"]["mulcher-3"].animation = mul_2.animation
    data.raw["furnace"]["mulcher-3"].collision_box = table.deepcopy( mul_2.collision_box )
    data.raw["furnace"]["mulcher-3"].selection_box = table.deepcopy( mul_2.selection_box )

    data.raw["furnace"]["mulcher-2"].next_upgrade = "mulcher-3"
end