if (instance_exists(connected_to))
{
	if (variable_instance_exists(connected_to,"powered") and instance_exists(obj_player))
	{
		#orig#()
	}
}
else
{
	connected_to = -1
}