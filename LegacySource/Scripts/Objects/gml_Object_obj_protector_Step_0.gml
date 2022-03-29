if (!instance_exists(obj_player))
{
	return false
}

audio_emitter_position(emitter, x, y, 150)
audio_emitter_velocity(emitter, hspeed, vspeed, 0)
audio_sound_gain_fx(sound, (0.15 + (booster_power * 0.003)), 0.16)
audio_sound_pitch(sound, (0.7 + (booster_power * 0.01)))
if global.underwater
    audio_sound_pitch(sound, (0.4 + (booster_power * 0.006)))
time++
eye_dir = point_direction(x, y, obj_player.x, obj_player.y)
if (point_distance(xstart, ystart, obj_player.x, obj_player.y) < detection_range)
{
    dir = eye_dir
    motion_add(dir, acceleration)
    following = 1
}
else
{
    dir = point_direction(x, y, xstart, (ystart + (sin((time / 10)) * 10)))
    motion_add(dir, acceleration_home)
    following = 0
}
booster_y += 5
booster_x = lerp(booster_x, x, 0.1)
booster_y = lerp(booster_y, y, 0.1)
booster_angle = (point_direction(x, y, booster_x, booster_y) + 90)
booster_power = point_distance(x, y, booster_x, booster_y)
speed *= damping
scr_dont_move_through_walls()
x = clamp(x, 60, (room_width - 60))
y = clamp(y, 60, (room_height - 60))
