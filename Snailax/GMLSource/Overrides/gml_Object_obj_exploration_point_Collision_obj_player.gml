if (!collectable)
    return false;
alarm[1] = 60
collectable = 0
if (room != snailax_editor_room)
{
	alarm = 1
	if (ds_list_find_index(global.save_collected_exploration_points, name) < 0)
	{
		with (obj_level_selection)
			collected_exploration_points += 1
		ds_list_add(global.save_collected_exploration_points, name)
		if (ds_list_size(global.save_collected_exploration_points) >= floor(15.333333333333334))
			scr_set_achievement("EXPLORATION_POINTS_1")
		if (ds_list_size(global.save_collected_exploration_points) >= floor(30.666666666666668))
			scr_set_achievement("EXPLORATION_POINTS_2")
		if (ds_list_size(global.save_collected_exploration_points) >= 46)
			scr_set_achievement("EXPLORATION_POINTS_3")
		scr_save_game()
	}
}
else
{
	image_alpha = 0.5
    image_blend = make_color_rgb(100, 100, 100)
}
sound = audio_play_sound(sou_explorationPointCollect, 0.95, false)
audio_sound_gain_fx(sound, 0.7, 0)
layer_fx = layer_get_id("Fx")
repeat round((30 * scr_particle_multiplyer()))
{
    idmerk = instance_create_layer(x, y, layer_fx, obj_fx_exploralosion)
    idmerk.speed = (20 + random(10))
    idmerk.direction = random(360)
    idmerk.image_blend = merge_color(image_blend, c_white, 0.4)
}
global.screenshake = max(150, global.screenshake)
obj_player.gamepad_rumble = max(obj_player.gamepad_rumble, 1)
idmerk = instance_create_layer(x, y, layer_fx, obj_fx_flare)
idmerk.image_blend = merge_color(image_blend, c_white, 0.5)
idmerk.image_xscale = 2
idmerk.image_yscale = 2
idmerk.image_alpha = 0.3
idmerk.decay = 0.975
idmerk = instance_create_layer(x, (y + 10), layer_fx, obj_fx_flare)
idmerk.image_blend = merge_color(image_blend, c_white, 0.5)
idmerk.image_xscale = 0.35
idmerk.image_yscale = 0.35
idmerk.image_alpha = 2
idmerk.decay = 0.97
idmerk = instance_create_layer(x, (y + 10), layer_fx, obj_fx_flare)
idmerk.image_blend = merge_color(image_blend, c_white, 1)
idmerk.image_xscale = 0.15
idmerk.image_yscale = 0.15
idmerk.image_alpha = 20
idmerk.decay = 0.95
