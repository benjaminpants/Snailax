delay = 60
delay_max = delay
range = 90
time = 0
h = 0
if (room != level_basic_copy_me)
{
	if (!global.save_pump_is_inverted)
		h = obj_levelstyler.hue
	image_blend = make_color_hsv((((((h - global.col_disco_light_hue_spread) + random((global.col_disco_light_hue_spread * 2))) + 2550) + global.col_disco_light_hue_offset) % 255), global.col_disco_light_saturation, 255)
}
else
{
	image_blend = make_color_rgb(irandom(255),irandom(255),irandom(255))
}
alarm = 120
image_angle = random(360)
if (x < 20 || x > (room_width - 20) || y < 20 || y > (room_height - 20))
{
    instance_destroy()
    return;
}
