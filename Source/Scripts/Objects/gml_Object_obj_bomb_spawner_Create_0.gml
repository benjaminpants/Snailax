if (global.save_difficulty == 0)
    spawn_rate = 300
if (global.save_difficulty == 1)
    spawn_rate = 200
if (global.save_difficulty == 2)
    spawn_rate = 100
if (global.save_difficulty == 3)
    spawn_rate = 80
spawn_in = 20
if (room != level_basic_copy_me)
{
	alarm = 1
	image_blend = c_black
}
else
{
	image_blend = c_white
}
image_speed = 0
xoffset = sprite_get_xoffset(sprite_index)
yoffset = sprite_get_yoffset(sprite_index)
