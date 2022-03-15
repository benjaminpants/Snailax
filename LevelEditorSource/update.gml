var lay_id, a, i;

x = (round((mouse_x / 60)) * 60)
y = (round((mouse_y / 60)) * 60)

//offsets because not every object has the same alignment point as the wall sprite
if (placing == obj_rusty_spike)
{
	offset_x = 30
	offset_y = 60
}
else if (placing == obj_playerspawn)
{
	offset_x = 30
	offset_y = 30
}
else
{
	offset_x = 0
	offset_y = 0
}

if (mouse_check_button(mb_left) and (x != prev_x or y != prev_y))
{
	prev_x = x
	prev_y = y
	instance_create_layer(x + offset_x, y + offset_y, placing_layer, placing)
	//destroy the current level styler
	instance_destroy(obj_levelstyler)
	//forcefully clear all the walllines
	lay_id = layer_get_id("WallLines")
	a = layer_get_all_elements(lay_id)
	for (i = 0; i < array_length_1d(a); i++)
		layer_sprite_destroy(a[i])
	//recreate the level styler
	instance_create_layer(0, 0, "Player", obj_levelstyler)
	audio_play_sound(sou_increaseHandicapA,0,false)
}

if mouse_check_button(mb_right)
{
	
	var inst = instance_place(x, y, placing) //only specifically checking for what your placing because i was too lazy to search up how to check for any object
	
	if (inst != noone)
	{
		instance_destroy(inst)
		audio_play_sound(sou_respawn,0,false)
		if (placing == obj_playerspawn)
		{
			audio_play_sound(sou_fail,0,false)
		}
	}
	
	//destroy the current level styler
    instance_destroy(obj_levelstyler)
	//forcefully clear all the walllines
    lay_id = layer_get_id("WallLines")
    a = layer_get_all_elements(lay_id)
    for (i = 0; i < array_length_1d(a); i++)
        layer_sprite_destroy(a[i])
	//recreate the level styler
    instance_create_layer(0, 0, "Player", obj_levelstyler)
}


if (keyboard_check_pressed(ord("1")))
{
    placing = obj_wall
    placing_layer = "Walls"
}

if (keyboard_check_pressed(ord("2")))
{
    placing = obj_wallB
    placing_layer = "Walls"
}

if (keyboard_check_pressed(ord("3")))
{
    placing = obj_rusty_spike
    placing_layer = "Spikes"
}

if (keyboard_check_pressed(ord("4")))
{
    placing = obj_playerspawn
    placing_layer = "Player"
}


if (keyboard_check_pressed(vk_f1))
{
	if (not level_saved)
	{
		show_message("Please save your level before testing!")
	}
	else
	{
		instance_create_layer(obj_playerspawn.x, obj_playerspawn.y, "Player", obj_player)
		instance_create_layer(obj_playerspawn.x, obj_playerspawn.y, "Player", asset_get_index("obj_ai_level_0" + string(squid_level)))
		instance_destroy(obj_playerspawn)
		instance_destroy()
	}
}


if (keyboard_check_pressed(vk_f2)) //handles saving files
{
	var file_name = get_string("Enter Level File Name (WITHOUT EXTENSION)", "my_epic_level")
	squid_level = get_integer("Choose squid variation.\n0=No traps will spawn\n1=Ground spike traps will spawn\n2=Wall, ceiling, and ground spike traps will spawn\n3=All spikes plus cats\n4=All spike traps, Less ceiling spikes(no cats)",1)
	var SaveData = "1\n" + string(squid_level) //file version + squid ai variation
	
	SaveData = SaveData + "\n-\n"

	with (obj_wall)
	{
		
		SaveData = SaveData + object_get_name(object_index) + ":"
		
		SaveData = SaveData + string(x)
		
		SaveData = SaveData + "," + string(y) + ","
		
		SaveData = SaveData + "\n"

	}
	
	with (obj_rusty_spike)
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


	var file
	file = file_text_open_write(program_directory + file_name + ".wysld")
	file_text_write_string(file, SaveData)
	file_text_close(file)
	
	level_saved = true
}

if (keyboard_check_pressed(vk_f3)) //handles loading files
{

	instance_destroy(obj_wall)
	instance_destroy(obj_wallB)
	instance_destroy(obj_playerspawn)
	instance_destroy(obj_rusty_spike)

	var file_name = get_string("Enter Level File Name (WITHOUT EXTENSION)", "my_epic_level")
	
	var header_data = []
	
	var level_data = []
	
	var has_passed_header = false
	
	var file
	file = file_text_open_read(program_directory + file_name + ".wysld")
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
	
	squid_level = real(header_data[1]) //SQUID GAMES?
	
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
		else if (name == "obj_rusty_spike")
		{
			layer_to_place_on = "Spikes"
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
	
	//destroy the current level styler
	instance_destroy(obj_levelstyler)
	//forcefully clear all the walllines
	lay_id = layer_get_id("WallLines")
	a = layer_get_all_elements(lay_id)
	for (i = 0; i < array_length_1d(a); i++)
		layer_sprite_destroy(a[i])
	//recreate the level styler
	instance_create_layer(0, 0, "Player", obj_levelstyler)
	
	
	level_saved = true
	
	audio_play_sound(sou_game_start,0,false)



}