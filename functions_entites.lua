DIR = {}
DIR.graphics_path = "__arborium_upgrade__/graphics"
DIR.sprites_path = DIR.graphics_path

------------------------------------------------------------------------------------------------------------------------------------------------------

-- sprite definitions for animation layers etc.

function get_sprite_def(name, resolution, frame_count, line_length, shadow, repeat_count, animation_speed, width, height, x, y, scale, shift, blend_mode, flags, tint, direction_count, apply_runtime_tint, run_mode, hr_version) 
	local variation_count = nil
	if frame_count and frame_count < 0 then
		variation_count = math.abs(frame_count)
		frame_count = nil
	end
	local layer = {
		draw_as_shadow = shadow,
		filename = string.format("%s/%s/%s.png", DIR.sprites_path, resolution, name),
		blend_mode = blend_mode,
		animation_speed = animation_speed,
		repeat_count = repeat_count,
		frame_count = frame_count,
		direction_count = direction_count,
		line_length = line_length,
		height = height,
		width = width,
		x = x,
		y = y,
		scale = scale,
		shift = shift,
		tint = tint,
		apply_runtime_tint = apply_runtime_tint,
		run_mode = run_mode,
		priority = "high",
		flags = flags,
		variation_count = variation_count,
	}
	if hr_version then
		layer.hr_version = util.table.deepcopy(layer)
		layer.hr_version.filename = string.format("%s/%s/hr_%s.png", DIR.sprites_path, resolution, name)
		layer.hr_version.scale = hr_version.scale
		layer.hr_version.shift = hr_version.shift
		layer.hr_version.height = hr_version.height
		layer.hr_version.width = hr_version.width
		layer.hr_version.x = hr_version.x
		layer.hr_version.y = hr_version.y
		layer.hr_version.line_length = hr_version.line_length or layer.hr_version.line_length
		layer.hr_version.frame_count = hr_version.frame_count or layer.hr_version.frame_count
	end
	return layer
end

function get_multi_sprite_def(name, files, resolution, frame_count, line_length, shadow, repeat_count, animation_speed, width, height, x, y, scale, shift, blend_mode, flags, tint, direction_count, apply_runtime_tint, run_mode) 
	local stripes = {}
	for i=1,files do
		table.insert(stripes, { filename = string.format("%s/%s/%s-%d.png", DIR.sprites_path, resolution, name, i), width_in_frames = frame_count, height_in_frames = direction_count / files })
	end
	return {
		draw_as_shadow = shadow,
		stripes = stripes, 
		blend_mode = blend_mode,
		animation_speed = animation_speed,
		repeat_count = repeat_count,
		frame_count = frame_count,
		direction_count = direction_count,
		line_length = line_length,
		height = height,
		width = width,
		x = x,
		y = y,
		scale = scale,
		shift = shift,
		tint = tint,
		apply_runtime_tint = apply_runtime_tint,
		run_mode = run_mode,
		priority = "high",
		flags = flags,
		max_advance = 1, -- caps vehicle wheel animation
	}
end

function offset(shift1, shift2)
	return ({shift1[1]-shift2[1], shift1[2]-shift2[2]})
end

function shift_calc(x,y,tw,th,w,h)
	return {((tw/2) - (x + (w/2)))/64, ((th/2) - (y + (h/2)))/64}
end

function get_layer(name, frame_count, line_length, shadow, repeat_count, animation_speed, width, height, x, y, tw, th, shift, blend_mode, flags, tint, direction_count, apply_runtime_tint, run_mode, scale, hr_version) 
	if not scale ~= nil then scale = 0.5 end
	if shift then 
		shift = offset(shift, shift_calc(x,y,tw,th,width,height))
	end
	if hr_version then
		hr_version.x = hr_version.x or 0
		hr_version.y = hr_version.y or 0

		if hr_version and not hr_version.scale then scale = 1 table.insert(hr_version, {scale = 0.5}) end
		
		if hr_version.shift then
			local _tw, _th
			if not hr_version.tw then _tw = hr_version.width else _tw = hr_version.tw end
			if not hr_version.th then _tw = hr_version.height else _th = hr_version.th end
			hr_version.shift = offset(
				hr_version.shift, shift_calc(
					hr_version.x, 
					hr_version.y, 
					_tw,
					_th,
					hr_version.width,
					hr_version.height
				)
			)
		end
	end
	local layer = get_sprite_def(name, "", frame_count, line_length, shadow, repeat_count, animation_speed, width, height, x, y, scale, shift, blend_mode, flags, tint, direction_count, apply_runtime_tint, run_mode, hr_version)
	return layer
end

function get_multi_layer(name, files, frame_count, line_length, shadow, repeat_count, animation_speed, width, height, x, y, tw, th, shift, blend_mode, flags, tint, direction_count, apply_runtime_tint, run_mode) 
	shift = offset(shift, shift_calc(x,y,tw,th,width,height))
	local layer = get_multi_sprite_def(name, files, "", frame_count, line_length, shadow, repeat_count, animation_speed, width, height, x, y, 0.5, shift, blend_mode, flags, tint, direction_count, apply_runtime_tint, run_mode)
	return layer
end

------------------------------------------------------------------------------------------------------------------------------------------------------
