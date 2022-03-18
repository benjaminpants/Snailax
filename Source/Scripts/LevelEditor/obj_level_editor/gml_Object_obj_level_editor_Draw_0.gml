if (cur_mode == "placing")
{
	draw_sprite_ext(spr_wall_original, image_index, (x - (grid_x * 0.125)), (y - (grid_y * 0.125)), 1.25, 1.25, 0, c_white, 0.75)
	draw_sprite(object_get_sprite(placing), 0, x + offset_x, y + offset_y)
}