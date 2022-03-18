if (keyboard_check_pressed(vk_f9))
{
	var thing = get_string("SUS ROOM NAME","B_17_disco_puzzle_05x")
	show_message("ROOM ID: " + string(asset_get_index(thing)))
}