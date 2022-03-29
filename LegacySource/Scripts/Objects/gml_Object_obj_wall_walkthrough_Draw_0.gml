if (instance_exists(obj_level_editor))
{
	draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,merge_color(image_blend,c_white,0.4),0.25)
}
else
{
	draw_self()
}