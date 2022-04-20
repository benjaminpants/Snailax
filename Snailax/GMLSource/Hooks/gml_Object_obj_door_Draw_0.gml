var og_exists = instance_exists(connected_to)
var second_cond = false
if (og_exists)
{
	second_cond = variable_instance_exists(connected_to,"powered")
}
if (og_exists and second_cond)
{
	#orig#()
}
else
{
	mycol = merge_color(image_blend, c_red, 0.5)
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, mycol, image_alpha)
	draw_sprite_ext(spr_door_top, 0, x, y, 1, 1, image_angle, mycol, 1)
	if (image_yscale > 0)
		draw_sprite_ext(spr_door_top2, 0, (x + lengthdir_x((image_yscale * 60), (image_angle - 90))), (y + lengthdir_y((image_yscale * 60), (image_angle - 90))), 1, -1, image_angle, mycol, 1)
	draw_set_font(font_aiTalk)
	draw_set_colour(c_white)
	draw_text(x,y,"X")
}