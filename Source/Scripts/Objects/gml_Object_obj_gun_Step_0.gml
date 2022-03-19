override_image_angle_timer -= 1
if (bubble_gum_mode == -1)
    bubble_gum_mode = instance_exists(obj_levelstyler_bubblegum)
if (instance_exists(obj_player))
{
	image_angle = point_direction(x, y, obj_player.x, obj_player.y)
	if (override_image_angle_timer >= 0)
		image_angle = override_image_angle
}
image_blend = obj_levelstyler.col_wall_outline
