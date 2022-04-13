for (var i = 0; i < array_length_1d(all_objects); i += 1)
{
	if (all_objects[i] == asset_get_index(argument0))
	{
		return all_objects_layers[i]
	}
}

return "Walls"