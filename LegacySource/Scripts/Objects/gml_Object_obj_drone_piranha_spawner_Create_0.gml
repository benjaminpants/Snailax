spawn_rate = 600000
alarm = 1
image_blend = c_black
image_speed = 0
xoffset = sprite_get_xoffset(sprite_index)
yoffset = sprite_get_yoffset(sprite_index)
if (room != level_basic_copy_me)
{
	paussed = 0
	spawn_in = 2
}
else
{
	spawn_in = 1
	paussed = true
	visible = true
}
