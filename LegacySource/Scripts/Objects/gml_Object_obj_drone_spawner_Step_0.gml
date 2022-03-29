
if (not instance_exists(obj_level_editor))
{
	if (paussed == 0)
	{
		spawn_in = max((spawn_in - 1), 0)
		if (spawn_in <= 0)
		{
			image_blend = obj_levelstyler.col_traps
			if obj_ai_general.enabled
			{
				paussed = 1
				spawn_in = spawn_rate
				idmerk = instance_create_layer(x, y, "Traps", obj_enemy_drone)
				idmerk.spawner = id
				idmerk.acceleration *= drone_acceleration_multi
				sound = audio_play_sound_at(choose(300, 301, 302, 303), x, y, 0, 90, 2500, 1.5, false, 0.1)
				audio_sound_gain_fx(sound, 0.6, 0)
				audio_sound_pitch(sound, (0.8 + random(0.4)))
				if global.underwater
					audio_sound_pitch(sound, (0.4 + random(0.1)))
			}
		}
	}
}
