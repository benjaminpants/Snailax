if (keyboard_check_pressed(vk_f9))
{
	var thing = get_integer("char id",global.current_character)
	global.current_character = thing
}