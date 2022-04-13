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
				show_message("Not implemented!")
				//var actstring = "Which mechanic do you want to enable?"
				//for (var i = 0; i < max_gimmicks; i += 1)
				//{
				//}
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
	scr_editor_load()
	
	global.last_loaded_c_level = current_level_name

	scr_editor_play()

	
}


if (keyboard_check_pressed(vk_f2)) //handles saving files
{
	scr_editor_save()
}

if (keyboard_check_pressed(vk_f3) or (global.last_loaded_c_level != "")) //handles loading files
{

	scr_editor_load()


}

if (keyboard_check_pressed(vk_f1))
{
	
	scr_editor_play()

	
}