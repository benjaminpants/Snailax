if (instance_exists(obj_level_editor))
{
	draw_sprite_ext(sprite_index,image_index,x,y,1,1,0,image_blend,0.25)
}
else
{
	draw_self()
}