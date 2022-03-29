saveseed = random_get_seed()
random_set_seed((x + (y * 1.119)))
hitground = 0
image_speed = 0
if (room != level_basic_copy_me)
{
	alarm = 1
	image_index = random(10000)
	image_yscale = (0.6 + random(0.5))
	image_xscale = choose(1, -1)
}
else
{
	if obj_levelstyler.minimalist_color_mode
		image_blend = obj_levelstyler.col_traps
	else
		image_blend = merge_color(obj_levelstyler.col_wall_outline, obj_levelstyler.col_traps, 0.3)
}
random_set_seed(saveseed)
