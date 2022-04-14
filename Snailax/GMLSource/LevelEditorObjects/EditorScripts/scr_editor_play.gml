if (not level_saved)
{
	show_message("Please save your level before testing!")
	return false
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
	instance_destroy(obj_playerspawn)
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

	image_index = obj_wall
	
	walls_to_merge = []
	
	for (var i = 0; i < (ceil(room_width / 60) + 1); i += 1)
	{
		for (var j = 0; j < (ceil(room_height / 60) + 1); j += 1)
		{
			var obj = instance_place((i * 60),(j * 60), obj_wall)
			if (obj != noone)
			{
				with (obj)
				{
					if (object_index == obj_wall or object_index == obj_wallB or object_index == obj_wall_brain)
					{
						obj_level_editor.walls_to_merge[array_length_1d(obj_level_editor.walls_to_merge)] = id
					}
				}
			}
		}
	}
	
	for (var i = 0; i < array_length_1d(walls_to_merge); i += 1)
	{
		with (walls_to_merge[i])
		{
			scr_editor_tile_merge()
		}
	}
	
	walls_to_merge = []
	
	instance_destroy(obj_playerspawn)
	if (current_gimmicks[0] != 0)
	{
		var mini = instance_create_layer(0,0,"Minigames",obj_d_main)
		mini.interval = current_gimmicks[0]
	}
	
	if (current_gimmicks[1])
	{
		instance_create_layer(0,0,"Player",obj_dark_level)
	}
	
	instance_destroy()
}
return true