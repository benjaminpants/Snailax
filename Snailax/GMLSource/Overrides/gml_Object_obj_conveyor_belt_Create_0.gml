image_blend = c_black
if (room != snailax_editor_room)
{
	alarm[0] = 1
}
else
{
	image_blend = c_white
}
image_speed = 0
if (room != snailax_editor_room)
{
	if (!instance_exists(obj_conveyor_belt_sound_handler))
		instance_create_layer(0, 0, "Fx", obj_conveyor_belt_sound_handler)
}
