visible = true
collectable = 1
image_blend = obj_levelstyler.col_exploration_point
if (room != level_basic_copy_me)
{
	if (ds_list_find_index(global.save_collected_exploration_points, name) >= 0)
	{
		collectable = 0
		image_alpha = 0.5
		image_blend = make_color_rgb(100, 100, 100)
	}
}