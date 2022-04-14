var file_name = get_string("Enter Level File Name (WITHOUT EXTENSION)", current_level_name)
current_level_name = file_name
if (show_question("Do you want to change squid's settings?(These default to squid doing nothing)"))
{
	squid_ground_spike_probability = get_integer("Ground Spike Probability(0-100)", squid_ground_spike_probability * 100) / 100
	squid_wall_spike_probability = get_integer("Wall Spike Probability(0-100)", squid_wall_spike_probability * 100) / 100
	squid_ceiling_spike_probability = get_integer("Ceiling Spike Probability(0-100)", squid_ceiling_spike_probability * 100) / 100
	squid_air_cat_probability = get_integer("Air Spike Probability(0-100)", squid_air_cat_probability * 100) / 100
	if (instance_exists(obj_gun))
	{
		squid_badball_probability = get_integer("Bullet Probability(0-1000)", squid_badball_probability * 1000) / 1000
	}
	else
	{
		squid_badball_probability = 0
	}
	if (instance_exists(obj_ice_spike))
	{
		squid_ice_spike_down_probability = get_integer("Ice Spike Fall Probability(0-100)", squid_ice_spike_down_probability * 100) / 100
	}
	else
	{
		squid_ice_spike_down_probability = 0
	}
	squid_fireworks_probability = get_integer("Firework Probability(0-100)", squid_fireworks_probability * 100) / 100
	squid_conveyor_belt_change_probability = get_integer("Conveyer Belt Change Probability(0-100)", squid_conveyor_belt_change_probability * 100) / 100
	squid_laser_probability = get_integer("Laser Probablity(0-100)", squid_laser_probability * 100) / 100
}
var SaveData = "5\n" //file version

SaveData = SaveData + string(squid_ground_spike_probability) + "\n"
SaveData = SaveData + string(squid_wall_spike_probability) + "\n"
SaveData = SaveData + string(squid_ceiling_spike_probability) + "\n"
SaveData = SaveData + string(squid_air_cat_probability) + "\n"
SaveData = SaveData + string(squid_badball_probability) + "\n"
SaveData = SaveData + string(squid_combletely_disabled) + "\n" //not implemented
SaveData = SaveData + string(squid_ice_spike_down_probability) + "\n"
SaveData = SaveData + string(squid_fireworks_probability) + "\n"
SaveData = SaveData + string(squid_conveyor_belt_change_probability) + "\n"
SaveData = SaveData + string(squid_laser_probability) + "\n"

SaveData = SaveData + string(room_mult_x) + "\n"
SaveData = SaveData + string(room_mult_y) + "\n"

SaveData = SaveData + string(current_song) + "\n"

SaveData = SaveData + string(current_theme) + "\n"

for (var i = 0; i < max_gimmicks; i += 1)
{
	SaveData = SaveData + string(current_gimmicks[i]) + ","
}

SaveData = SaveData + "|\n"

SaveData = SaveData + "-\n"

var added_objects = []

for (var i = 0; i < array_length_1d(all_objects); i += 1)
{
	with (all_objects[i])
	{
		for (var j = 0; j < array_length_1d(added_objects); j += 1) //make sure we dont get any duplicates caused by parenting
		{
			if (added_objects[j] == id)
			{
				continue
			}
		}
		
		
		SaveData = SaveData + object_get_name(object_index) + ":"
		
		added_objects[array_length_1d(added_objects) + 1] = id
		
		SaveData = SaveData + string(x)
		
		SaveData = SaveData + "," + string(y) + ","
		
		if (object_index == obj_squasher or object_index == obj_underwater_current or object_index == obj_fish)
		{
			SaveData = SaveData + string(image_angle) + ","
		}
		
		SaveData = SaveData + "\n"

	}
}

added_objects = [] //discard the array

var file
file = file_text_open_write(program_directory + "/snailax_levels/" + file_name + ".wysld")
file_text_write_string(file, SaveData)
file_text_close(file)

level_saved = true

return true