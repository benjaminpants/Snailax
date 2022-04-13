
var has_reached_max_x = false

var attempt_x = 0

var size_x = 1


var has_reached_max_y = false

var attempt_y = 0

var size_y = 1

while (!has_reached_max_x)
{
	attempt_x++
	var obj = instance_place(x + (attempt_x * 60),y, object_index)
	if (obj != noone)
	{
		if (obj.object_index == object_index and (obj.image_xscale == 1 and obj.image_yscale == 1)) //handle game maker parenting and size
		{
			instance_destroy(obj)
			size_x++
		}
		else
		{
			attempt_x--
			has_reached_max_x = true
		}
	}
	else
	{
		attempt_x--
		has_reached_max_x = true
	}
}

while (!has_reached_max_y)
{
	attempt_y++
	var i = 0
	var mark_for_destruction = []
	repeat (attempt_x + 1)
	{
		if (!has_reached_max_y)
		{
			var obj = instance_place(x + (i * 60),y + (attempt_y * 60), object_index)
			if (obj != noone)
			{
				if (obj.object_index == object_index and (obj.image_xscale == 1 and obj.image_yscale == 1)) //handle game maker parenting and size
				{
					mark_for_destruction[array_length_1d(mark_for_destruction)] = obj
				}
				else
				{
					has_reached_max_y = true
					attempt_y--
				}
			}
			else
			{
				has_reached_max_y = true
				attempt_y--
			}
			i++
		}
	}
	if (!has_reached_max_y)
	{
		size_y++
		for (var j = 0; j < array_length_1d(mark_for_destruction); j += 1)
		{
			instance_destroy(mark_for_destruction[j])
		}
	}
}

image_xscale = size_x

image_yscale = size_y