if (instance_exists(obj_level_editor))
{
	return false
}

speedup_timer--
if (speedup_timer == 1)
{
    sound = audio_play_sound_at(sou_underw_dec_b, x, y, 100, 50, 2500, 0.6, false, 0.4)
    audio_sound_gain_fx(sound, 0.6, 0)
    audio_sound_pitch(sound, (0.7 + random(0.6)))
}
if global.underwater
{
    if (random(1) < (0.005 * scr_particle_multiplyer()))
        part_particles_create(global.part_sys_fx, ((x - random(40)) + 20), ((y - random(40)) + 20), global.part_type_underwBubbles, 1)
}
target_speed = basic_speed
target_scale = 1
warncol_target = 0
if (speedup_timer > 0)
{
    target_speed = speedup_speed
    target_scale = 1.2
    warncol_target = 1
}
else
{
    range = (speedup_speed * obj_ai_general.setting_calculate_frames_ahead)
    playsound = 0
    if (collision_line(x, y, (x + lengthdir_x(range, base_dir)), (y + lengthdir_y(range, base_dir)), obj_ai_general, false, true) != -4)
    {
        speedup_timer = obj_ai_general.setting_calculate_frames_ahead
        playsound = 1
    }
    if (collision_line(x, y, (x + lengthdir_x(range, base_dir)), (y + lengthdir_y(range, base_dir)), obj_player, false, true) != -4)
    {
        speedup_timer = obj_ai_general.setting_calculate_frames_ahead
        playsound = 1
    }
    if playsound
    {
        sound = audio_play_sound_at(sou_underw_acc_b, x, y, 100, 50, 2500, 0.6, false, 0.4)
        audio_sound_gain_fx(sound, 0.6, 0)
        audio_sound_pitch(sound, (0.7 + random(0.6)))
        if global.underwater
        {
            repeat ceil((2 * scr_particle_multiplyer()))
                part_particles_create(global.part_sys_fx, ((x - random(20)) + 10), ((y - random(20)) + 10), global.part_type_underwBubbles, 1)
        }
    }
}
base_speed = lerp(speed, target_speed, 0.5)
scale = lerp(scale, target_scale, 0.1)
warncol = lerp(warncol, warncol_target, 0.1)
base_x += lengthdir_x(base_speed, base_dir)
base_y += lengthdir_y(base_speed, base_dir)
if position_meeting((base_x + lengthdir_x(30, base_dir)), (base_y + lengthdir_y(30, base_dir)), obj_wall)
{
    base_dir += 180
    image_angle += 180
    time += (10 * pi)
    fishwhiggletime += 94.24777960769379
}
fishwhiggletime += base_speed
time++
hwiggle = (lengthdir_x(sin((fishwhiggletime / 30)), (base_dir + 90)) * wiggle_strength)
vwiggle = (lengthdir_y(sin((fishwhiggletime / 30)), (base_dir + 90)) * wiggle_strength)
fishwiggle = (sin((fishwhiggletime / 5)) * 8)
wingwiggle = (sin((fishwhiggletime / 12.5)) * 8)
x = (base_x + hwiggle)
y = (base_y + vwiggle)
