for (var i = 0; i < array_length_1d(all_objects); i += 1)
{
	instance_destroy(all_objects[i])
}


var file_name = ""

if (global.last_loaded_c_level == "")
{
	file_name = get_string("Enter Level File Name (WITHOUT EXTENSION)", "my_epic_level")
}
else
{
	file_name = global.last_loaded_c_level
}



var header_data = []

var level_data = []

var has_passed_header = false

var file_path = program_directory + "/snailax_levels/" + file_name + ".wysld"

if (not file_exists(file_path))
{
	show_message("Please retype the level name. The one provided isn't valid.")
	global.last_loaded_c_level = ""
	starting_play_mode = false
	return false
}

cam_x = 0
cam_y = 0


var file
file = file_text_open_read(file_path)
var i = 0
while (!file_text_eof(file))
{
	i++
	var read_text = file_text_readln(file)
	
	read_text = string_replace(read_text, "\n", "")
	
	
	if (has_passed_header == false)
	{
		if (string_char_at(read_text,1) == "-") // "-" seperates the header(version data, squid AI, etc) from the object data
		{
			has_passed_header = true
		}
		else
		{
			header_data[array_length_1d(header_data)] = read_text
		}
	}
	else
	{
		level_data[array_length_1d(level_data)] = read_text
	}
}

var level_version = real(header_data[0])

if (level_version > 5)
{
	show_message("This format is for a future version! Expect weird issues when loading and be sure to check the github for future versions!")
}

if (level_version == 1)
{
	squid_ground_spike_probability = 0
	squid_wall_spike_probability = 0
	squid_ceiling_spike_probability = 0
	squid_air_cat_probability = 0
	squid_badball_probability = 0
	squid_combletely_disabled = 0
	squid_ice_spike_down_probability = 0
	squid_fireworks_probability = 0
	squid_conveyor_belt_change_probability = 0.01
	squid_laser_probability = 0
	show_message("This level is file format v1! Beware that unless you resave Squid won't do anything!")
	level_version = 2
}
else
{
	squid_ground_spike_probability = real(header_data[1])
	squid_wall_spike_probability = real(header_data[2])
	squid_ceiling_spike_probability = real(header_data[3])
	squid_air_cat_probability = real(header_data[4])
	squid_badball_probability = real(header_data[5])
	squid_combletely_disabled = real(header_data[6])
	squid_ice_spike_down_probability = real(header_data[7])
	squid_fireworks_probability = real(header_data[8])
	squid_conveyor_belt_change_probability = real(header_data[9])
	squid_laser_probability = real(header_data[10])
}
if (level_version == 2)
{
	room_mult_x = 1
	room_mult_y = 1
	level_version = 3
}
else
{
	room_mult_x = real(header_data[11])
	room_mult_y = real(header_data[12])
}
if (level_version == 3)
{
	level_version = 4
	current_song = 0
	current_theme = 0
}
else
{
	current_song = real(header_data[13])
	current_theme = real(header_data[14])
}
if (level_version == 4)
{
	current_gimmicks = [0, false]
	level_version = 5
}
else
{
	var k = 1
	var current_gimmick_index = 0
	while (string_char_at(header_data[15],k) != "|")
	{
		var gim = ""
		while (string_char_at(header_data[15],k) != ",")
		{
			gim = gim + string_char_at(header_data[15],k)
			k++
		}
		current_gimmicks[current_gimmick_index] = real(gim)
		k++
		current_gimmick_index++
	}
}

room_width = 1920 * room_mult_x
room_height = 1080 * room_mult_y
scr_colgrid_destroy()
scr_colgrid_fill()

//F to pay respects to "SQUID GAMES?" comment, RIP 2022-2022

var test = 0

for (var j = 0; j < array_length_1d(level_data); j += 1)
{
	var layer_to_place_on = "Walls"
	var data = level_data[j]
	var k = 1
	var name = ""
	
	var x_pos = ""
	
	var y_pos = ""
	
	var p_bonus = ""
	
	var parse_size = false
	
	var size_to_set = ""
	
	var parse_bonus_val = ""
	
	while (string_char_at(data,k) != ":")
	{
		name = name + string_char_at(data,k)
		k++
	}
	
	if (name == "obj_rusty_spike")
	{
		name = "obj_spike_permanent"
	}
	layer_to_place_on = scr_editor_get_layer(name)
	
	if (name == "obj_squasher")
	{
		parse_bonus_val = "rot"
	}
	else if (name == "obj_underwater_current")
	{
		parse_bonus_val = "rot"
	}
	else if (name == "obj_fish")
	{
		parse_bonus_val = "rot"
	}
	else if (name == "obj_door")
	{
		parse_bonus_val = "rot"
	}
	
	if (name == "obj_antenna")
	{
		parse_bonus_val = "cor"
	}
	else if (name == "obj_power_generator")
	{
		parse_bonus_val = "cor"
	}
	else if (name == "obj_antenna_big_range")
	{
		parse_bonus_val = "cor"
	}
	
	if (name == "obj_door")
	{
		parse_size	= true
	}
	
	k++
	
	while (string_char_at(data,k) != ",")
	{
		x_pos = x_pos + string_char_at(data,k)
		k++
	}
	
	x_pos = real(x_pos)
	
	k++
	
	while (string_char_at(data,k) != ",")
	{
		y_pos = y_pos + string_char_at(data,k)
		k++
	}
	
	y_pos = real(y_pos)
	
	if (parse_bonus_val != "")
	{
		k++
		
		while (string_char_at(data,k) != ",")
		{
			p_bonus = p_bonus + string_char_at(data,k)
			k++
		}
		p_bonus = real(p_bonus)
	}
	else
	{
		p_bonus = 0
	}
	//parse size
	if (parse_size)
	{
		k++
		
		while (string_char_at(data,k) != ",")
		{
			size_to_set = size_to_set + string_char_at(data,k)
			k++
		}
		size_to_set = real(size_to_set)
	}
	else
	{
		size_to_set = 1
	}
	
			
	var new_object = instance_create_layer(x_pos, y_pos, layer_to_place_on, asset_get_index(name))
	if (name == "obj_door")
	{
		new_object.yoff = 0
		new_object.xoff = 0
		new_object.yscale = size_to_set
	}
	new_object.image_yscale = size_to_set
	if (parse_bonus_val == "rot")
	{
		new_object.image_angle = p_bonus
	}
	if (parse_bonus_val == "cor")
	{
		new_object.corrupted = p_bonus
	}
	
	
}

current_level_name = file_name

level_saved = true

if (global.last_loaded_c_level == "")
{
	audio_play_sound(sou_game_start,0,false)
}
global.last_loaded_c_level = ""

file_text_close(file)

return true