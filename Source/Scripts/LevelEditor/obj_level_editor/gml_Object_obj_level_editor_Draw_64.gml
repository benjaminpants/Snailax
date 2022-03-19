if (cur_mode == "placing")
{

	if (keyboard_check(vk_f9))
	{
		scr_draw_subtitle("F1 to play, F2 to save, F3 to load, F4 quick play, F2 ingame returns you to the editor", c_white)
	}
	else
	{
		scr_draw_subtitle("Currently Selected Object:" + object_get_name(placing) + "\n1-9 to change objects, Z for Menu, F9 for more", c_white)
	}

}
else
{
	if (cur_mode == "palette_select")
	{
		//draw sprites make some of em bigger im too tired to describe this properly now
		for (var i = (floor(cur_selected_item / 5) * 5); i < clamp(((floor(cur_selected_item / 5) * 5) + 5),0, array_length_1d(all_objects)); i++)
		{
			var offsets = scr_getitemoffsets(all_objects[i])
			var sprite_attempt = object_get_sprite(all_objects[i])
			var actual_sprite_data = scr_get_item_sprite_index(sprite_attempt)
			if (cur_selected_item == i)
			{
				draw_sprite_ext(actual_sprite_data[1], actual_sprite_data[0], (((i mod 5) + 5) * 120) + (offsets[0] * 2.25), (offsets[1] * 2.25) + ((display_get_gui_height() / 2) - 90),2.25 * actual_sprite_data[2],2.25 * actual_sprite_data[2],0,c_white,1)
			}
			else
			{
				draw_sprite_ext(actual_sprite_data[1], actual_sprite_data[0], (((i mod 5) + 5) * 120) + (offsets[0] * 2), (offsets[1] * 2) + ((display_get_gui_height() / 2) - 60),2 * actual_sprite_data[2],2 * actual_sprite_data[2],0,c_white,1)
			}
		}
		scr_draw_subtitle(object_get_name(all_objects[cur_selected_item]) + "\nArrow keys to navigate, enter to select.", c_white)
	}
	else if (cur_mode == "palette_change")
	{
		for (var i = 0; i < 9; i++)
		{
			if (global.current_palette[i] != -1)
			{
				var sprite_attempt = object_get_sprite(global.current_palette[i])
				var actual_sprite_data = scr_get_item_sprite_index(sprite_attempt)
				var offsets = scr_getitemoffsets(global.current_palette[i])
				draw_sprite_ext(actual_sprite_data[1], actual_sprite_data[0], (i * 120) + (offsets[0] * 2), 120 + (offsets[1] * 2), 2 * actual_sprite_data[2], 2 * actual_sprite_data[2], 0, c_white, 1)
			}
			draw_set_font(font_aiTalk)
			if (i == cur_selected_slot)
			{
				draw_set_colour(c_yellow)
			}
			else
			{
				draw_set_colour(c_white)
			}
			draw_text(((i + 1) * 120) - 60, 64, string(i + 1))
			draw_set_colour(c_white)
		}
		scr_draw_subtitle("Arrow keys to navigate, select a slot to insert " + object_get_name(all_objects[cur_selected_item]) + " into the palette.", c_white)
	}
	else if (cur_mode == "main")
	{
		for (var i = 0; i < 9; i++) //draw the current palette
		{
			if (global.current_palette[i] != -1)
			{
				var offsets = scr_getitemoffsets(global.current_palette[i])
				var sprite_attempt = object_get_sprite(global.current_palette[i])
				var actual_sprite_data = scr_get_item_sprite_index(sprite_attempt)
				draw_sprite_ext(actual_sprite_data[1], actual_sprite_data[0], (i * 120) + (offsets[0] * 2), 120 + (offsets[1] * 2), 2 * actual_sprite_data[2], 2 * actual_sprite_data[2], 0, c_white, 1)
			}
			draw_set_font(font_aiTalk)
			draw_set_colour(c_white)
			draw_text(((i + 1) * 120) - 60, 64, string(i + 1))
		}
		scr_draw_subtitle("This menu is incomplete! Z to exit menu/go to place mode, X to adjust palette. C to adjust level size.", c_white)
	}
	
	
	
	//draw the very basic mouse cursor, this appears on all non-building mode areas
	var mx = (window_mouse_get_x()/window_get_width()) * display_get_gui_width()
	var my = (window_mouse_get_y()/window_get_height()) * display_get_gui_height()
	draw_sprite_ext(spr_arrow_button_tip, 0, mx + 10, my + 10, 0.5,0.5, 140, c_white, 1)
}