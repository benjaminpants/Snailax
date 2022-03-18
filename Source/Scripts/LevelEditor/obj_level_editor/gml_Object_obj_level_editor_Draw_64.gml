if (keyboard_check(vk_f9))
{
	scr_draw_subtitle("F1 to play, F2 to save, F3 to load", c_white)
}
else
{
	scr_draw_subtitle("Currently Selected Object:" + object_get_name(placing) + "\n1-5 to change objects, F9 for more", c_white)
}