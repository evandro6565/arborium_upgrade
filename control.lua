local util = require('__core__.lualib.util')
--local table = require("__flib__.table")
--conf = require "__arborium_upgrade__.config"

script.on_init(function() init() end)
script.on_load(function() up() global = global or {} end)
script.on_event(defines.events.on_player_mined_entity, function(event) on_destroyed(event)  end)
script.on_event(defines.events.on_robot_mined_entity, function(event) on_destroyed(event)  end)
script.on_event(defines.events.on_entity_died, function(event) on_destroyed(event) end)

script.on_event(defines.events.on_built_entity, function(event) register(event.created_entity) end)
script.on_event(defines.events.on_robot_built_entity, function(event) register(event.created_entity) end)

--script.on_event(defines.events.on_research_cancelled, function (event) technology(event.research) end)
--script.on_event(defines.events.on_research_started, function (event) technology(event.research) end)
script.on_event(defines.events.on_research_finished, function (event) technology(event.research) end)

script.on_event(defines.events.on_selected_entity_changed, function (event)
    if event.last_entity then
        selected(event.last_entity)
    end
end)

--script.on_event(defines.events.on_tick, function() end)

function print(txt)
    for id, player in pairs(game.players) do
        player.print(txt)
    end
end

function random(n)
    return math.floor(math.random()*n)+1
end


function init()
    global = global or {}
    if not global.stone_crusher then global.stone_crusher = {} end
    if not global.technology_up then 
        global.technology_up = {
            def = {true, 2},
            lvl_1 = {false, 5},
            lvl_2 = {false, 7}
        }
    end
    up()
    --update_register()
end

function onBuildHandler(event)
end

function technology(research)
    local researched = false
    if research then
        if research.name == "quarry-deep-excavation-up1" then 
            if research.researched then researched = true end
            global.technology_up.def[1] = not researched
            global.technology_up.lvl_1[1] = researched
            global.technology_up.lvl_2[1] = false
            up()
            update_register()
        end
        if research.name == "quarry-deep-excavation-up2" then 
            if research.researched then researched = true end
            global.technology_up.def[1] = not researched
            global.technology_up.lvl_1[1] = false
            global.technology_up.lvl_2[1] = researched
            up()
            update_register()
        end
    end
end

function up()
    radius = global.technology_up.def[1] and global.technology_up.def[2]
    radius = global.technology_up.lvl_1[1] and global.technology_up.lvl_1[2] or radius
    radius = global.technology_up.lvl_2[1] and global.technology_up.lvl_2[2] or radius
end

function register(entity)
    local p, ent, sc, surface, Quarry
    local meteorite = false
    local count_r_found = 0
    local r_found = {}
    if entity.name == "quarry" then
        p = entity.position
        surface = entity.surface
        ent = surface.find_entities_filtered{ area = {{p.x-radius, p.y-radius}, {p.x+radius, p.y+radius}} }
        init()
        for _, e in ipairs(ent) do
            if e.name:find("rock",1,true) or e.name:find("cliff",1,true) or e.name:find("meteor") then
                count_r_found = count_r_found + 1
                r_found[count_r_found] = e
                if e.name:find("meteor") then meteorite = true end
                if count_r_found >= 10 then break end
            end
        end
        if meteorite then 
            Quarry = {["up1"] = "quarry-sp-l2", ["up2"] = "quarry-sp-l3", ["up3"] = "quarry-sp-l4"} 
        else 
            Quarry = {["up1"] = "quarry-l2", ["up2"] = "quarry-l3", ["up3"] = "quarry-l4"} 
        end
        if count_r_found == 1 then
            entity.destroy()
            sc = surface.create_entity{ name = Quarry.up1, position = p, force = "player" }
            data_reg(sc, r_found[1], "up1", true)
        end
        if count_r_found == 2 then
            entity.destroy()
            sc = surface.create_entity{ name = Quarry.up2, position = p, force = "player" }
            data_reg(sc, r_found, "up2", true)
        end
        if count_r_found >= 3 then
            entity.destroy()
            sc = surface.create_entity{ name = Quarry.up3, position = p, force = "player" }
            data_reg(sc, r_found, "up3", true)
        end

        if count_r_found == 0 then
            data_reg(entity, nil, "def", false --[[not-resource]])
        end
    end
    if game then
        technology(game.players[1].force.previous_research)
    end
end

function update_register()
    if #global.stone_crusher > 0 then
        local p, res, sc, meteorite
        local count_r_found = 0
        local r_found = {}
        for index, data in ipairs(global.stone_crusher) do
            if data.stone_crusher.up ~= "up3" then
                p = data.stone_crusher.data.position
                res = surface.find_entities_filtered{ area = {{p.x-radius, p.y-radius}, {p.x+radius, p.y+radius}} }
                for _, e in ipairs(res) do
                    if e.name:find("rock",1,true) or e.name:find("cliff",1,true) or e.name:find("meteorite",1,true) then
                        count_r_found = count_r_found + 1
                        r_found[count_r_found] = e
                        
                        if e.name:find("meteorite",1,true) then meteorite = true end
                        if count_r_found >= 4 then break end
                    end
                end

                if meteorite then 
                    Quarry = {["up1"] = "quarry-sp-l2", ["up2"] = "quarry-sp-l3", ["up3"] = "quarry-sp-l4"} 
                else 
                    Quarry = {["up1"] = "quarry-l2", ["up2"] = "quarry-l3", ["up3"] = "quarry-l4"} 
                end
                if count_r_found == 1 then
                    data.stone_crusher.data.destroy()
                    sc = surface.create_entity{ name = Quarry.up1, position = p, force = "player" }
                    data_reg(sc, r_found[1], "up1", true)
                    data_remove(index)
                end
                if count_r_found == 2 then
                    data.stone_crusher.data.destroy()
                    sc = surface.create_entity{ name = Quarry.up2, position = p, force = "player" }
                    data_reg(sc, r_found, "up2", true)
                    data_remove(index)
                end
                if count_r_found >= 3 then
                    data.stone_crusher.data.destroy()
                    sc = surface.create_entity{ name = Quarry.up3, position = p, force = "player" }
                    data_reg(sc, r_found, "up3", true)
                    data_remove(index)
                end
            end
        end
    end
end

function data_remove(index)
    global.stone_crusher[index] = nil
    table.remove(global.stone_crusher, index)
end

function data_reg(entity, resource, up, f)
    local resource_name, resource_position
    if resource and resource.name == nil then 
        resource_name, resource_position = {}, {}
        for i, r in pairs(resource) do
            resource_name[i] = r.name
            resource_position[i] = r.position
        end
    elseif resource ~= nil then
        resource_name = resource.name
        resource_position = resource.position
    end
    local data = {
        resource = {
            found = f,
            entity_resource = resource,
            name = type(resource_name) == "table" and util.table.deepcopy(resource_name) or resource_name,
            position = type(resource_position) == "table" and util.table.deepcopy(resource_position) or resource_position,
        },
        stone_crusher = {
            up = up,
            data = entity,
            line = nil,
            rec = nil
        }
    }
    resource_conf(data)
    global.stone_crusher[entity.unit_number] = data
end

function resource_conf(stone_crusher_data, opt)
    if stone_crusher_data.resource.entity_resource == nil then return end

    if not stone_crusher_data.resource.entity_resource.name then
        for _, resource in pairs(stone_crusher_data.resource.entity_resource) do
            if resource.health and resource.health < resource.prototype.max_health then resource.health = resource.prototype.max_health end
            resource.destructible = opt or false 
            resource.minable = opt or false 
        end
    else
        local resource = stone_crusher_data.resource.entity_resource
        if resource.health and resource.health < resource.prototype.max_health then resource.health = resource.prototype.max_health end
        resource.destructible = opt or false 
        resource.minable = opt or false 
    end
end

function selected(entity)
    if entity.name:find "quarry-" ~= nil then
        local color = {0.28, 0.79, 0.28, 0.1}
        local r = radius
        local time_to_live = 70
        local data_s = global.stone_crusher[entity.unit_number]
        if data_s then
            if data_s.stone_crusher.rec == nil or data_s.stone_crusher.rec and not rendering.is_valid(data_s.stone_crusher.rec) then
                data_s.stone_crusher.rec = rendering.draw_rectangle
                { 
                    color=color, 
                    surface=entity.surface, 
                    left_top=entity,
                    right_bottom=entity, 
                    left_top_offset= {-r, -r},
                    right_bottom_offset= {r, r},
                    time_to_live= time_to_live,
                    only_in_alt_mode=true,
                    filled=true,
                    draw_on_ground=true
                }
            end
            
            if data_s.resource.found then
                local l_id = (type(data_s.stone_crusher.line) == "table") and data_s.stone_crusher.line[1] or data_s.stone_crusher.line
                if data_s.stone_crusher.line == nil or data_s.stone_crusher.line and not rendering.is_valid(l_id) then
                    if type(data_s.resource.name) == "table" then
                        data_s.stone_crusher.line = type(data_s.stone_crusher.line) == "table" and data_s.stone_crusher.line or {}

                        for index, resource_p in ipairs(data_s.resource.position) do
                            data_s.stone_crusher.line[index] = rendering.draw_line
                            { 
                                color = {0.67, 0.39, 0.03},
                                width = 3,
                                draw_on_ground=true,
                                only_in_alt_mode=true,
                                time_to_live= time_to_live,
                                surface=entity.surface,
                                from=entity, from_offset={0,0.2},
                                to=resource_p, to_offset={0,0.2},
                                gap_length=0.2, dash_length=0.5,
                            }
                        end
                    else
                        data_s.stone_crusher.line = rendering.draw_line
                        { 
                            color = {0.67, 0.39, 0.03},
                            width = 3,
                            draw_on_ground=true,
                            only_in_alt_mode=true,
                            time_to_live= time_to_live,
                            surface=entity.surface,
                            from=entity, from_offset={0,0.2},
                            to=data_s.resource.position, to_offset={0,0.2},
                            gap_length=0.2, dash_length=0.5,
                        }
                    end
                end
            end
        end
    end
end

function on_destroyed(event)
    if event.entity.name:find "quarry-" ~= nil then
        local unit_number = event.entity.unit_number

        if global.stone_crusher[unit_number] then
            resource_conf(global.stone_crusher[unit_number], true)
            global.stone_crusher[unit_number] = nil
            table.remove(global.stone_crusher, unit_number)
        end
    end
end