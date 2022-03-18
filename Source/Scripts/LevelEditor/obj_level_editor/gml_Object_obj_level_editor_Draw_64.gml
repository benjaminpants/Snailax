if (keyboard_check(vk_f9))
{
	scr_draw_subtitle("F1 to play, F2 to save, F3 to load, F2 while ingame to go back to the editor", c_white)
}
else
{
	scr_draw_subtitle("Currently Selected Object:" + object_get_name(placing) + "\n1-5 to change objects, F9 for more", c_white)
}