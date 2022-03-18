var object_to_attach = argument0

var use_spike_offsets = argument1

if (place_meeting(object_to_attach.x,object_to_attach.y + 60,obj_wall))
{
	image_angle = 0
}
else if (place_meeting(object_to_attach.x,object_to_attach.y - 90,obj_wall))
{
	image_angle = 180
	if (use_spike_offsets)
	{
		object_to_attach.y -= 60
	}
}
else if (place_meeting(object_to_attach.x + 60,object_to_attach.y + 30,obj_wall))
{
	image_angle = 90
	if (use_spike_offsets)
	{
		object_to_attach.x += 30
		object_to_attach.y -= 30
	}
}
else if (place_meeting(object_to_attach.x - 60,object_to_attach.y + 30,obj_wall))
{
	image_angle = 270
	if (use_spike_offsets)
	{
		object_to_attach.x -= 30
		object_to_attach.y -= 30
	}
}