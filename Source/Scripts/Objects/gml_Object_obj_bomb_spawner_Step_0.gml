if (not instance_exists(obj_level_editor))
{
	spawn_in -= 1
	if (spawn_in <= 0)
	{
		spawn_in = spawn_rate
		bomb = instance_create_layer(x, y, "Traps", obj_bomb)
		if global.underwater
			bomb.underwater = 1
		image_blend = obj_levelstyler.col_traps
		sound = audio_play_sound_at(choose(300, 301, 302, 303), x, y, 0, 90, 2500, 1.5, false, 0.15)
		audio_sound_gain_fx(sound, 0.6, 0)
		audio_sound_pitch(sound, (0.8 + random(0.4)))
		if global.underwater
			audio_sound_pitch(sound, (0.4 + random(0.1)))
	}

}