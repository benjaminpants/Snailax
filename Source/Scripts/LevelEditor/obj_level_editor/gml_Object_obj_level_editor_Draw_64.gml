if (cur_mode == "placing")
{

	if (keyboard_check(vk_f9))
	{
		scr_draw_subtitle("F1 to play, F2 to save, F3 to load, F2 while ingame to go back to the editor", c_white)
	}
	else
	{
		scr_draw_subtitle("Currently Selected Object:" + object_get_name(placing) + "\n1-5 to change objects, F9 for more", c_white)
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
			if (cur_selected_item == i)
			{
				draw_sprite_ext(object_get_sprite(all_objects[i]), 0, (((i mod 5) + 5) * 120) + (offsets[0] * 2.25), (offsets[1] * 2.25) + ((display_get_gui_height() / 2) - 90),2.25,2.25,0,c_white,1)
			}
			else
			{
				draw_sprite_ext(object_get_sprite(all_objects[i]), 0, (((i mod 5) + 5) * 120) + (offsets[0] * 2), (offsets[1] * 2) + ((display_get_gui_height() / 2) - 60),2,2,0,c_white,1)
			}
		}
		scr_draw_subtitle("Arrow keys to navigate, enter to select and enter palette edit mode.", c_white)
	}
	
	
	
	//draw the very basic mouse cursor, this appears on all non-building mode areas
	var mx = (window_mouse_get_x()/window_get_width()) * display_get_gui_width()
	var my = (window_mouse_get_y()/window_get_height()) * display_get_gui_height()
	draw_sprite_ext(spr_arrow_button_tip, 0, mx + 10, my + 10, 0.5,0.5, 140, c_white, 1)
}