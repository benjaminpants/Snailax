var lay_id, a, i;


//offsets because not every object has the same alignment point as the wall sprite
var offsets = scr_getitemoffsets(placing)
offset_x = offsets[0]
offset_y = offsets[1]


if (cur_mode != "placing")
{
	//do non-level editing code here, mostly navigating menus!
	if (cur_mode == "palette_select")
	{
		if (keyboard_check_pressed(vk_left))
		{
			cur_selected_item = clamp(cur_selected_item - 1, 0, array_length_1d(all_objects) - 1)
			audio_play_sound(sou_no_audiogroup_test,0,false)
		}
		if (keyboard_check_pressed(vk_right))
		{
			cur_selected_item = clamp(cur_selected_item + 1, 0, array_length_1d(all_objects) - 1)
			audio_play_sound(sou_no_audiogroup_test,0,false)
		}
		if (keyboard_check_pressed(vk_enter))
		{
			cur_mode = "palette_change"
			audio_play_sound(sou_game_start,0,false)
		}
	}
	else if (cur_mode == "palette_change") //ELSE IF SO THE ENTER TRIGGER THINGY DOESNT TRIGGER AGAIN
	{
		if (keyboard_check_pressed(vk_left))
		{
			cur_selected_slot = clamp(cur_selected_slot - 1, 0, 8)
			audio_play_sound(sou_no_audiogroup_test,0,false)
		}
		if (keyboard_check_pressed(vk_right))
		{
			cur_selected_slot = clamp(cur_selected_slot + 1, 0, 8)
			audio_play_sound(sou_no_audiogroup_test,0,false)
		}
		if (keyboard_check_pressed(vk_enter))
		{
			audio_play_sound(sou_game_start,0,false)
			global.current_palette[cur_selected_slot] = all_objects[cur_selected_item]
			global.current_palette_layers[cur_selected_slot] = all_objects_layers [cur_selected_item]
			cur_mode = "main"
		}
	}
	else if (cur_mode == "main")
	{
		if (keyboard_check_pressed(ord("Z")))
		{
			cur_mode = "placing"
		}
		if (keyboard_check_pressed(ord("X")))
		{
			cur_mode = "palette_select"
		}
		if (keyboard_check_pressed(ord("C")))
		{
			room_mult_x = get_integer("Room Size Horizontal(In screens, divided by 100)\n100 = 1 screen\n125 = 1.25 screens\n200 = 2 screens",room_mult_x * 100) / 100
			room_mult_y = get_integer("Room Size Vertical(In screens, divided by 100)\n100 = 1 screen\n125 = 1.25 screens\n200 = 2 screens",room_mult_y * 100) / 100
			if (room_mult_x < 1)
			{
				show_message("Horizontal Size can't be less then 1 screen!")
				room_mult_x = 1
			}
			if (room_mult_y < 1)
			{
				show_message("Vertical Size can't be less then 1 screen!")
				room_mult_y = 1
			}
			room_width = 1920 * room_mult_x
			room_height = 1080 * room_mult_y
		}
	}
	return false;
}

x = (round((mouse_x / grid_x)) * grid_x)
y = (round((mouse_y / grid_y)) * grid_y)

camera_set_view_pos(view_camera[0],cam_x,cam_y)

if (keyboard_check(ord("W")))
{
	cam_y -= 5
}
if (keyboard_check(ord("S")))
{
	cam_y += 5
}
if (keyboard_check(ord("A")))
{
	cam_x -= 5
}
if (keyboard_check(ord("D")))
{
	cam_x += 5
}
cam_x = clamp(cam_x,0,room_width - 1920)
cam_y = clamp(cam_y,0,room_height - 1080)


if (mouse_check_button(mb_left) and (x != prev_x or y != prev_y))
{
	prev_x = x
	prev_y = y
	instance_create_layer(x + offset_x, y + offset_y, placing_layer, placing)
	audio_play_sound(sou_increaseHandicapA,0,false)
	level_saved = false
}

if mouse_check_button(mb_right)
{
	
	var inst = instance_place(x, y, placing) //only specifically checking for what your placing because i was too lazy to search up how to check for any object
	
	if (inst != noone)
	{
		level_saved = false
		instance_destroy(inst)
		audio_play_sound(sou_respawn,0,false)
		if (placing == obj_playerspawn)
		{
			audio_play_sound(sou_fail,0,false)
		}
	}
	
}



for (var i = 0; i < 9; i++)
{
	if (keyboard_check_pressed(ord(string(i + 1))))
	{
		if (global.current_palette[i] != -1)
		{
			placing = global.current_palette[i]
			placing_layer = global.current_palette_layers[i]
		}
	}
}

if (keyboard_check_pressed(ord("Z")))
{
	cur_mode = "main"
}

if (keyboard_check_pressed(vk_f4))
{
	starting_play_mode = true
}


if (keyboard_check_pressed(vk_f2)) //handles saving files
{
	var file_name = get_string("Enter Level File Name (WITHOUT EXTENSION)", current_level_name)
	current_level_name = file_name
	if (show_question("Do you want to change squid's settings?(These default to squid doing nothing)"))
	{
		squid_ground_spike_probability = get_integer("Ground Spike Probability(0-100)", squid_ground_spike_probability * 100) / 100
		squid_wall_spike_probability = get_integer("Wall Spike Probability(0-100)", squid_wall_spike_probability * 100) / 100
		squid_ceiling_spike_probability = get_integer("Ceiling Spike Probability(0-100)", squid_ceiling_spike_probability * 100) / 100
		squid_air_cat_probability = get_integer("Air Spike Probability(0-100)", squid_air_cat_probability * 100) / 100
		if (instance_exists(obj_gun))
		{
			squid_badball_probability = get_integer("Bullet Probability(0-1000)", squid_badball_probability * 1000) / 1000
		}
		else
		{
			squid_badball_probability = 0
		}
		squid_fireworks_probability = get_integer("Firework Probability(0-100)", squid_fireworks_probability * 100) / 100
		squid_conveyor_belt_change_probability = get_integer("Conveyer Belt Change Probability(0-100)", squid_conveyor_belt_change_probability * 100) / 100
		squid_laser_probability = get_integer("Laser Probablity(0-100)", squid_laser_probability * 100) / 100
	}
	var SaveData = "3\n" //file version + squid ai variation
	
	SaveData = SaveData + string(squid_ground_spike_probability) + "\n"
	SaveData = SaveData + string(squid_wall_spike_probability) + "\n"
	SaveData = SaveData + string(squid_ceiling_spike_probability) + "\n"
	SaveData = SaveData + string(squid_air_cat_probability) + "\n"
	SaveData = SaveData + string(squid_badball_probability) + "\n" //not implemented because the laser thingies aren't yet
	SaveData = SaveData + string(squid_combletely_disabled) + "\n" //not implemented
	SaveData = SaveData + string(squid_ice_spike_down_probability) + "\n" //not implemented
	SaveData = SaveData + string(squid_fireworks_probability) + "\n"
	SaveData = SaveData + string(squid_conveyor_belt_change_probability) + "\n"
	SaveData = SaveData + string(squid_laser_probability) + "\n"
	
	SaveData = SaveData + string(room_mult_x) + "\n"
	SaveData = SaveData + string(room_mult_y)
	
	SaveData = SaveData + "\n-\n"

	with (obj_wall)
	{
		
		SaveData = SaveData + object_get_name(object_index) + ":"
		
		SaveData = SaveData + string(x)
		
		SaveData = SaveData + "," + string(y) + ","
		
		SaveData = SaveData + "\n"

	}
	
	with (obj_spike_permanent)
	{
		
		SaveData = SaveData + object_get_name(object_index) + ":"
		
		SaveData = SaveData + string(x)
		
		SaveData = SaveData + "," + string(y) + ","
		
		SaveData = SaveData + "\n"

	}
	
	with (obj_playerspawn)
	{
		
		SaveData = SaveData + object_get_name(object_index) + ":"
		
		SaveData = SaveData + string(x)
		
		SaveData = SaveData + "," + string(y) + ","
		
		SaveData = SaveData + "\n"

	}
	
	with (obj_conveyor_belt)
	{
		
		SaveData = SaveData + object_get_name(object_index) + ":"
		
		SaveData = SaveData + string(x)
		
		SaveData = SaveData + "," + string(y) + ","
		
		SaveData = SaveData + "\n"

	}
	
	with (obj_bomb_spawner)
	{
		
		SaveData = SaveData + object_get_name(object_index) + ":"
		
		SaveData = SaveData + string(x)
		
		SaveData = SaveData + "," + string(y) + ","
		
		SaveData = SaveData + "\n"

	}
	
	with (obj_sh_gun)
	{
		
		SaveData = SaveData + object_get_name(object_index) + ":"
		
		SaveData = SaveData + string(x)
		
		SaveData = SaveData + "," + string(y) + ","
		
		SaveData = SaveData + "\n"

	}
	
	with (obj_gun)
	{
		
		SaveData = SaveData + object_get_name(object_index) + ":"
		
		SaveData = SaveData + string(x)
		
		SaveData = SaveData + "," + string(y) + ","
		
		SaveData = SaveData + "\n"

	}
	
	with (obj_enemy)
	{
		
		SaveData = SaveData + object_get_name(object_index) + ":"
		
		SaveData = SaveData + string(x)
		
		SaveData = SaveData + "," + string(y) + ","
		
		SaveData = SaveData + "\n"

	}
	
	with (obj_bubble)
	{
		
		SaveData = SaveData + object_get_name(object_index) + ":"
		
		SaveData = SaveData + string(x)
		
		SaveData = SaveData + "," + string(y) + ","
		
		SaveData = SaveData + "\n"

	}
	
	with (obj_drone_spawner)
	{
		
		SaveData = SaveData + object_get_name(object_index) + ":"
		
		SaveData = SaveData + string(x)
		
		SaveData = SaveData + "," + string(y) + ","
		
		SaveData = SaveData + "\n"

	}
	
	with (obj_sh_enemy_spawnpoint_normy)
	{
		
		SaveData = SaveData + object_get_name(object_index) + ":"
		
		SaveData = SaveData + string(x)
		
		SaveData = SaveData + "," + string(y) + ","
		
		SaveData = SaveData + "\n"

	}
	
	with (obj_exploration_point)
	{
		
		SaveData = SaveData + object_get_name(object_index) + ":"
		
		SaveData = SaveData + string(x)
		
		SaveData = SaveData + "," + string(y) + ","
		
		SaveData = SaveData + "\n"

	}


	var file
	file = file_text_open_write(program_directory + "/snailax_levels/" + file_name + ".wysld")
	file_text_write_string(file, SaveData)
	file_text_close(file)
	
	level_saved = true
}

if (keyboard_check_pressed(vk_f3) or starting_play_mode or (global.last_loaded_c_level != "")) //handles loading files
{

	//TODO: you know I should probably just make a for loop that iterates through all valid editor objects and clear them
	instance_destroy(obj_wall)
	instance_destroy(obj_wallB)
	instance_destroy(obj_playerspawn)
	instance_destroy(obj_spike_permanent)
	instance_destroy(obj_conveyor_belt)
	instance_destroy(obj_bomb_spawner)
	instance_destroy(obj_sh_gun)
	instance_destroy(obj_gun)
	instance_destroy(obj_enemy)
	instance_destroy(obj_bubble)
	instance_destroy(obj_drone_spawner)
	instance_destroy(obj_exploration_point)


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
		return false;
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
	}
	
	room_width = 1920 * room_mult_x
	room_height = 1080 * room_mult_y
	
	//squid_level = real(header_data[1]) //SQUID GAMES?
	
	var test = 0
	
	for (var j = 0; j < array_length_1d(level_data); j += 1)
	{
		var layer_to_place_on = "Walls"
		var data = level_data[j]
		var k = 1
		var name = ""
		
		var x_pos = ""
		
		var y_pos = ""
		
		while (string_char_at(data,k) != ":")
		{
			name = name + string_char_at(data,k)
			k++
		}
		
		if (name == "obj_playerspawn")
		{
			layer_to_place_on = "Player"
		}
		else if (name == "obj_rusty_spike" or name == "obj_spike_permanent")
		{
			name = "obj_spike_permanent"
			layer_to_place_on = "Spikes"
		}
		else if (name == "obj_conveyor_belt")
		{
			layer_to_place_on = "Goal"
		}
		else if (name == "obj_bomb_spawner")
		{
			layer_to_place_on = "MiniGames"
		}
		else if (name == "obj_sh_gun")
		{
			layer_to_place_on = "Player"
		}
		else if (name == "obj_destructable_wall")
		{
			layer_to_place_on = "MiniGames"
		}
		else if (name == "obj_gun")
		{
			layer_to_place_on = "Spikes"
		}
		else if (name == "obj_enemy")
		{
			layer_to_place_on = "Traps"
		}
		else if (name == "obj_bubble")
		{
			layer_to_place_on = "MiniGames"
		}
		else if (name == "obj_drone_spawner")
		{
			layer_to_place_on = "Traps"
		}
		else if (name == "obj_sh_enemy_spawnpoint_normy")
		{
			layer_to_place_on = "Spikes"
		}
		else if (name == "obj_exploration_point")
		{
			layer_to_place_on = "Goal"
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
				
		instance_create_layer(x_pos, y_pos, layer_to_place_on, asset_get_index(name))
		
	}
	
	with (obj_sh_gun) //THIS IS AWFUL BUT IT WORKS SO I COULD CARE LESS
	{
		instance_create_layer(x, y, "Player", object_index)
		instance_destroy()
	}
	
	current_level_name = file_name
	
	level_saved = true
	
	if (global.last_loaded_c_level == "")
	{
		audio_play_sound(sou_game_start,0,false)
	}
	global.last_loaded_c_level = ""

	file_text_close(file)


}

if (keyboard_check_pressed(vk_f1) or starting_play_mode)
{
	if (not level_saved)
	{
		show_message("Please save your level before testing!")
	}
	else
	{
		//destroy the current level styler
		instance_destroy(obj_levelstyler)
		//forcefully clear all the walllines
		lay_id = layer_get_id("WallLines")
		a = layer_get_all_elements(lay_id)
		for (i = 0; i < array_length_1d(a); i++)
			layer_sprite_destroy(a[i])
		//recreate the level styler
		instance_create_layer(0, 0, "Player", obj_levelstyler)
		
		global.last_loaded_c_level = current_level_name
		
		with (obj_spike_permanent)
		{
			scr_rotate_object(id,true)
		}
	
		if (instance_exists(obj_conveyor_belt)) //properly initialize conveyer sounds
		{
			if (!instance_exists(obj_conveyor_belt_sound_handler))
				instance_create_layer(0, 0, "Fx", obj_conveyor_belt_sound_handler)
		}
	
		with (obj_conveyor_belt) //conveyer belts do your thing
		{
			alarm = 1
		}
		
		with (obj_bomb_spawner) //bomb spawners do your thing
		{
			alarm = 1
		}
		
		with (obj_sh_gun) //guns do your thing
		{
			alarm = 1
		}
		
		with (obj_bubble) //guns do your thing
		{
			alarm = 1
		}
		
		with (obj_exploration_point)
		{
			alarm = 1
		}
		
		with (obj_sh_enemy_spawnpoint_normy) //spawn the funny
		{
			alarm = 1
			visible = false
		}
		
		with (obj_destructable_wall) //destructable walls do pretty much nothing and sit there and be sad that you arent cool
		{
			alarm[1] = 1
		}
		
		with (obj_explosive_wall) //destructable walls do pretty much nothing and sit there and be sad that you arent cool
		{
			alarm[1] = 1
		}
		
		instance_create_layer(obj_playerspawn.x, obj_playerspawn.y, "Player", obj_player)
		var SQUIDGAMES = instance_create_layer(obj_playerspawn.x, obj_playerspawn.y, "Player", obj_ai_general)
		SQUIDGAMES.setting_ground_spike_probability = squid_ground_spike_probability
		SQUIDGAMES.setting_wall_spike_probability = squid_wall_spike_probability
		SQUIDGAMES.setting_ceiling_spike_probability = squid_ceiling_spike_probability
		SQUIDGAMES.setting_badball_probability = squid_badball_probability
		SQUIDGAMES.setting_ice_spike_down_probability = squid_ice_spike_down_probability
		SQUIDGAMES.setting_combletely_disabled = squid_combletely_disabled
		SQUIDGAMES.setting_air_cat_probability = squid_air_cat_probability
		SQUIDGAMES.setting_fireworks_probability = squid_fireworks_probability
		SQUIDGAMES.setting_conveyor_belt_change_probability = squid_conveyor_belt_change_probability
		SQUIDGAMES.setting_wall_spike_probability = squid_wall_spike_probability
		SQUIDGAMES.setting_laser_probability = squid_laser_probability
		instance_destroy(obj_playerspawn)
		starting_play_mode = false
		instance_destroy()
	}

	
}
