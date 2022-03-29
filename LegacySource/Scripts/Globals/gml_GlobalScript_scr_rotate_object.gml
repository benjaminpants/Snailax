var object_to_attach = argument0

var use_spike_offsets = argument1

var small_objects_accomidation = argument2


if (place_meeting(object_to_attach.x,object_to_attach.y + (30 + small_objects_accomidation),obj_wall))
{
	image_angle = 0
}
else if (place_meeting(object_to_attach.x,object_to_attach.y - (30 + small_objects_accomidation),obj_wall))
{
	image_angle = 180
	if (use_spike_offsets)
	{
		object_to_attach.y -= (60 + small_objects_accomidation)
	}
}
else if (place_meeting(object_to_attach.x + ((30 + small_objects_accomidation) * 2),object_to_attach.y + 30,obj_wall))
{
	image_angle = 90
	if (use_spike_offsets)
	{
		object_to_attach.x += (30 + small_objects_accomidation)
		object_to_attach.y -= 30
	}
}
else if (place_meeting(object_to_attach.x - ((30 + small_objects_accomidation) * 2),object_to_attach.y + 30,obj_wall))
{
	image_angle = 270
	if (use_spike_offsets)
	{
		object_to_attach.x -= (30 + small_objects_accomidation)
		object_to_attach.y -= 30
	}
}