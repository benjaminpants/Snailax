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
			var menu_option = get_integer("Welcome to the very stupid and dumb level properties window!!\n1 = Change Room Size\n2 = Change Song\n3 = Change Style", 0)
			if (menu_option == 1)
			{
				room_mult_x = get_integer("Room Size Horizontal(In screens, divided by 100)\n100 = 1 screen\n125 = 1.25 screens\n200 = 2 screens",room_mult_x * 100) / 100
				room_mult_y = get_integer("Room Size Vertical(In screens, divided by 100)\n100 = 1 screen\n125 = 1.25 screens\n200 = 2 screens",room_mult_y * 100) / 100
				if (room_mult_x < 1)
				{
					show_message("Horizontal Size can't be less then 1!")
					room_mult_x = 1
				}
				if (room_mult_y < 1)
				{
					show_message("Vertical Size can't be less then 1!")
					room_mult_y = 1
				}
				room_width = 1920 * room_mult_x
				room_height = 1080 * room_mult_y
				scr_colgrid_destroy()
				scr_colgrid_fill()
				level_saved = false
			}
			else if (menu_option == 2)
			{
				var wants_more_info = show_question("Do you want to see the song ID list first?")
				if (wants_more_info)
				{
					show_message("Song Names and IDs(TYPING ANY OTHER NUMBER MAY BREAK YOUR LEVEL)\n0 = Jump and Die\n1 = Simulated Life\n2 = Simulated Life(Underwater)\n4 = Make It Pain\n5 = Admitting Defeat\n6 = Shelly Fire\n7 = Demolition Warning\n8 = Disco Of Doom\n9 = Chill Zone\n10 = Mr. Dance\n11 = Underwater\n12 = Mama Squid\n13 = Death By Nanobots\n14 = Helpy Loves You\n15 = Winter Mode\n16 = Artifical Joy\n17 = Tension\n18 = Final Encounter\n19 = Reality Diving\n20 = Brain Ambience\n21 = Shelly Fire(Underwater)")
				}
				current_song = get_integer("Enter Song ID:", current_song)
				level_saved = false
			}
			else if (menu_option == 3)
			{
				current_theme = get_integer("Theme IDs:\n0 = Default\n1 = Bubblegum\n2 = Disco\n3 = Underwater\n4 = Brain\n5 = Winter\n6 = Glitchy", current_theme)
				level_saved = false
			}
			else if (menu_option == 4)
			{
				var actstring = "Which mechanic do you want to enable?"
				for (var i = 0; i < max_gimmicks; i += 1)
				{
				}
			}
		}
	}
	return false;
}

x = (round((mouse_x / grid_x)) * grid_x)
y = (round((mouse_y / grid_y)) * grid_y)

if (keyboard_check_pressed(ord("E")))
{
	if (placing == obj_squasher or placing == obj_fish)
	{
		placing_rotation += 90 //this used to be 30 but squasher collisions dont like being offgrid or not being perfect 90 degree angles :(
	}
	if (placing == obj_underwater_current)
	{
		placing_rotation += 30 
	}
	if (placing_rotation >= 360)
	{
		placing_rotation = 0
	}
}

if (keyboard_check_pressed(ord("Q")))
{
	if (placing == obj_underwater_current)
	{
		placing_rotation += 5 
	}
	if (placing_rotation >= 360)
	{
		placing_rotation = 0
	}
}

camera_set_view_pos(view_camera[0],cam_x,cam_y)

if (keyboard_check(ord("W")))
{
	cam_y -= 7
}
if (keyboard_check(ord("S")))
{
	cam_y += 7
}
if (keyboard_check(ord("A")))
{
	cam_x -= 7
}
if (keyboard_check(ord("D")))
{
	cam_x += 7
}
cam_x = clamp(cam_x,0,room_width - 1920)
cam_y = clamp(cam_y,0,room_height - 1080)


if (mouse_check_button(mb_left) and (x != prev_x or y != prev_y))
{
	prev_x = x
	prev_y = y
	var inst = instance_create_layer(x + offset_x, y + offset_y, placing_layer, placing)
	inst.image_angle = placing_rotation
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
			placing_rotation = 0
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
		if (instance_exists(obj_ice_spike))
		{
			squid_ice_spike_down_probability = get_integer("Ice Spike Fall Probability(0-100)", squid_ice_spike_down_probability * 100) / 100
		}
		else
		{
			squid_ice_spike_down_probability = 0
		}
		squid_fireworks_probability = get_integer("Firework Probability(0-100)", squid_fireworks_probability * 100) / 100
		squid_conveyor_belt_change_probability = get_integer("Conveyer Belt Change Probability(0-100)", squid_conveyor_belt_change_probability * 100) / 100
		squid_laser_probability = get_integer("Laser Probablity(0-100)", squid_laser_probability * 100) / 100
	}
	var SaveData = "4\n" //file version
	
	SaveData = SaveData + string(squid_ground_spike_probability) + "\n"
	SaveData = SaveData + string(squid_wall_spike_probability) + "\n"
	SaveData = SaveData + string(squid_ceiling_spike_probability) + "\n"
	SaveData = SaveData + string(squid_air_cat_probability) + "\n"
	SaveData = SaveData + string(squid_badball_probability) + "\n"
	SaveData = SaveData + string(squid_combletely_disabled) + "\n" //not implemented
	SaveData = SaveData + string(squid_ice_spike_down_probability) + "\n"
	SaveData = SaveData + string(squid_fireworks_probability) + "\n"
	SaveData = SaveData + string(squid_conveyor_belt_change_probability) + "\n"
	SaveData = SaveData + string(squid_laser_probability) + "\n"
	
	SaveData = SaveData + string(room_mult_x) + "\n"
	SaveData = SaveData + string(room_mult_y) + "\n"
	
	SaveData = SaveData + string(current_song) + "\n"
	
	SaveData = SaveData + string(current_theme) + "\n"
	
	SaveData = SaveData + "-\n"
	
	var added_objects = []
	
	for (var i = 0; i < array_length_1d(all_objects); i += 1)
	{
		with (all_objects[i])
		{
			for (var j = 0; j < array_length_1d(added_objects); j += 1) //make sure we dont get any duplicates caused by parenting
			{
				if (added_objects[j] == id)
				{
					continue
				}
			}
			
			
			SaveData = SaveData + object_get_name(object_index) + ":"
			
			added_objects[array_length_1d(added_objects) + 1] = id
			
			SaveData = SaveData + string(x)
			
			SaveData = SaveData + "," + string(y) + ","
			
			if (object_index == obj_squasher or object_index == obj_underwater_current or object_index == obj_fish)
			{
				SaveData = SaveData + string(image_angle) + ","
			}
			
			SaveData = SaveData + "\n"

		}
	}

	added_objects = [] //discard the array

	var file
	file = file_text_open_write(program_directory + "/snailax_levels/" + file_name + ".wysld")
	file_text_write_string(file, SaveData)
	file_text_close(file)
	
	level_saved = true
}

if (keyboard_check_pressed(vk_f3) or starting_play_mode or (global.last_loaded_c_level != "")) //handles loading files
{

	//TODO: you know I should probably just make a for loop that iterates through all valid editor objects and clear them
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
	
	if (level_version > 4)
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
		
		var p_rotation = ""
		
		var parse_rot = false
		
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
		else if (name == "obj_sh_gun2")
		{
			layer_to_place_on = "Player"
		}
		else if (name == "obj_sh_gun3")
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
		else if (name == "obj_protector")
		{
			layer_to_place_on = "Traps"
		}
		else if (name == "obj_ice_spike")
		{
			layer_to_place_on = "Traps"
		}
		else if (name == "obj_uplifter")
		{
			layer_to_place_on = "MiniGames"
		}
		else if (name == "obj_speedbooster")
		{
			layer_to_place_on = "MiniGames"
		}
		else if (name == "obj_evil_snail")
		{
			layer_to_place_on = "Traps"
		}
		else if (name == "obj_squasher")
		{
			layer_to_place_on = "Spikes"
			parse_rot = true
		}
		else if (name == "obj_underwater_current")
		{
			layer_to_place_on = "BackDecoration"
			parse_rot = true
		}
		else if (name == "obj_fish")
		{
			layer_to_place_on = "Traps"
			parse_rot = true
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
		
		if (parse_rot)
		{
			k++
			
			while (string_char_at(data,k) != ",")
			{
				p_rotation = p_rotation + string_char_at(data,k)
				k++
			}
			p_rotation = real(p_rotation)
		}
		else
		{
			p_rotation = 0
		}
				
		var new_object = instance_create_layer(x_pos, y_pos, layer_to_place_on, asset_get_index(name))
		new_object.image_angle = p_rotation
		
		
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
	starting_play_mode = false
	if (not level_saved)
	{
		show_message("Please save your level before testing!")
	}
	else
	{
		
		if (not instance_exists(obj_playerspawn))
		{
			show_message("You NEED a player spawn to play a level!")
			return false
		}
		
		being_destroyed = true
		
		//destroy the current level styler
		instance_destroy(obj_levelstyler)
		//forcefully clear all the walllines
		lay_id = layer_get_id("WallLines")
		a = layer_get_all_elements(lay_id)
		for (i = 0; i < array_length_1d(a); i++)
			layer_sprite_destroy(a[i])
		//recreate the level styler with the new style
		instance_create_layer(0, 0, "Player", all_styler_objects[current_theme])
		
		instance_destroy(obj_music_parent) //destroy any and all music!!! >:(
		
		instance_create_layer(0,0, "FadeOutIn", all_music_objects[current_song]) //create music :)
		
		global.last_loaded_c_level = current_level_name
		
		if (current_theme == 4)
		{
			instance_create_layer(-100,-100,"FadeOutIn", obj_no_squid_in_this_level)
			var stupid_word_amount = round(((room_width + room_height) / 2) / 350)
			var stupid_words = ["back_unicorn_betrayed_me","back_unicorn_hates_me","back_amelia_missing","back_amelia_betrayed_me", "back_writing_no_trust", "back_writing_Im_alone", "back_writing_scared", "back_writing_I_suffer", "back_writing_kill", "back_writing_deserved", "back_writing_infinite_suffer", "back_writing_suffer", "back_writing_superior", "back_nobody_understands", "back_writing_smarter", "back_writing_my_universe", "back_writing_Im_a_god", "back_writing_my_everything"]
			for (var i = 0; i < stupid_word_amount; i += 1)
			{
				var stupid_brain = instance_create_layer(random_range(64,room_width - 64),random_range(64,room_height - 64),"BackDecoration",obj_draw_text_in_brain)
				stupid_brain.image_angle = (random(1) - random(1)) * 13
				stupid_brain.loca_key = stupid_words[round(random_range(0,array_length_1d(stupid_words) - 1))]
				stupid_brain.parallax_move_with_cam = 0.2
			}
		}
		
		with (obj_spike_permanent)
		{
			scr_rotate_object(id,true,0)
		}
		
		with (obj_ice_spike)
		{
			scr_rotate_object(id,true,3)
			var workaround_object = instance_create_layer(x,y,"Traps",obj_ice_spike)
			workaround_object.image_angle = image_angle
			workaround_object.alarm = 1
			instance_destroy()
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
		
		with (obj_squasher)
		{
			alarm[4] = 1
		}
		
		with (obj_evil_snail)
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
		
		with (obj_protector)
		{
			alarm = 1
		}
		
		with (obj_underwater_current)
		{
			alarm = 1
		}
		
		with (obj_drone_piranha_spawner)
		{
			alarm = 1
			visible = false
			paussed = false
			
		}
		
		with (obj_jellyfish)
		{
			alarm = 1
			visible = true
		}
		with (obj_fish)
		{
			alarm = 1
			base_dir = image_angle
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
		if (current_theme == 3)
		{
			SQUIDGAMES.setting_calculate_frames_ahead += 10
		}
		instance_destroy(obj_playerspawn)
		instance_destroy()
	}

	
}