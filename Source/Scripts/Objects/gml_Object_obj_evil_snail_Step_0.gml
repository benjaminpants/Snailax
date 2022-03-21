if (not instance_exists(obj_player))
{
	return false
}

scr_autowhobble_update()
if (point_distance(x, y, obj_player.x, obj_player.y) < 400)
{
    if (global.input_x > 0)
        lookdir = -1
    if (global.input_x < 0)
        lookdir = 1
    scr_move_like_a_snail((-global.input_x), global.input_jump, global.input_jump_pressed, 1)
}
else
    scr_move_like_a_snail(0, global.input_jump, global.input_jump_pressed, 1)
if (abs(hspeed) <= 1)
    image_speed = 0
else
    image_speed = -2
if (vspeed < 0)
{
    if (vspeedprev >= 0)
    {
        if place_meeting(x, (y + 25), obj_wall)
        {
            sound = audio_play_sound_on(emitter, choose(279, 280, 281), false, 0.5)
            audio_sound_gain_fx(sound, 0.2, 0)
            audio_sound_pitch(sound, (0.9 + random(0.2)))
            if global.underwater
                audio_sound_pitch(sound, (0.5 + random(0.1)))
        }
    }
}
if (vspeed == 0)
{
    if (vspeedprev > 0)
    {
        if place_meeting(x, (y + 25), obj_wall)
        {
            sound = audio_play_sound_on(emitter, choose(282, 283, 284), false, 0.5)
            audio_sound_gain_fx(sound, 0.3, 0)
            audio_sound_pitch(sound, (0.9 + random(0.2)))
            if global.underwater
                audio_sound_pitch(sound, (0.5 + random(0.1)))
        }
    }
}
if (abs(hspeed) > 1 && vspeed == 0)
{
    if (movesound == -1)
    {
        movesound = audio_play_sound_on(emitter, sou_evilsnail_move_a, true, 0.7)
        audio_sound_pitch(movesound, (0.9 + random(0.2)))
        if global.underwater
            audio_sound_pitch(movesound, (0.5 + random(0.1)))
        audio_sound_set_track_position(movesound, random(5))
    }
    audio_sound_gain_fx(movesound, 0.2, 0)
}
else if (movesound != -1)
{
    audio_stop_sound(movesound)
    movesound = -1
}
vspeedprev = vspeed
