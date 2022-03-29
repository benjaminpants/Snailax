if (instance_exists(obj_level_editor))
{
	return false
}
audio_emitter_position(emitter, x, y, 100)
audio_emitter_velocity(emitter, hspeed, vspeed, 0)
flash *= 0.95
speed *= damping
if (random(1) < 0.2)
{
    if (collision_line(x, y, obj_ai_general.x, obj_ai_general.y, obj_wall, false, true) == -4)
    {
        target_x = obj_ai_general.x
        target_y = obj_ai_general.y
        target_player = 1
        if (!audio_is_playing(gnasound))
        {
            if (random(1) < 0.2)
            {
                gnasound = audio_play_sound_on(emitter, choose(326, 324, 9, 312, 8, 311, 317, 1), false, 0.65)
                audio_sound_gain_fx(gnasound, 0.8, 0)
                audio_sound_pitch(gnasound, (1.5 + random(1)))
            }
        }
    }
    else if (target_player == 0)
    {
        target_x = ((x + random(200)) - 100)
        target_y = ((y + random(200)) - 100)
        target_x = clamp(target_x, 60, (room_width - 60))
        target_y = clamp(target_y, 60, (room_height - 60))
        target_player = 0
    }
    else if (point_distance(x, y, target_x, target_y) < 20)
        target_player = 0
}
if (!enabled)
{
    if obj_ai_general.enabled
        enabled = 1
}
if enabled
{
    move_dir = point_direction(x, y, target_x, target_y)
    motion_add(move_dir, acceleration)
}
scr_dont_move_through_walls()
