if (instance_exists(obj_level_editor))
{
	aw_setting_whobble_strength = 0.02
	scr_autowhobble_update()
	return false
}
time++
aw_setting_whobble_strength = 0.02
scr_autowhobble_update()
attack_obj = obj_ai_general.id
if ready_to_attack
{
    if (point_distance(x, y, attack_obj.x, attack_obj.y) < attack_range)
    {
        if (collision_line(x, y, attack_obj.x, attack_obj.y, obj_wall, false, true) == -4)
        {
            if global.underwater
            {
                repeat ceil((4 * scr_particle_multiplyer()))
                    part_particles_create(global.part_sys_fx, ((x - random(60)) + 30), ((y - random(60)) + 30), global.part_type_underwBubbles, 1)
            }
            ready_to_attack = 0
            attack_x = ((attack_obj.x - 10) + random(20))
            attack_y = ((attack_obj.y - 10) + random(20))
            attack_speed = (point_distance(x, y, attack_obj.x, attack_obj.y) / obj_ai_general.setting_calculate_frames_ahead)
            direction = point_direction(x, y, attack_x, attack_y)
            speed = attack_speed
            warncol_target = 1
            size_target = 1.1
            sound = audio_play_sound_at(sou_underw_acc_b, x, y, 100, 50, 2500, 0.6, false, 0.4)
            audio_sound_gain_fx(sound, 0.6, 0)
            audio_sound_pitch(sound, (0.7 + random(0.6)))
        }
    }
}
else if (point_distance(x, y, attack_x, attack_y) <= (attack_speed + 1))
{
    warncol_target = 0
    size_target = 1
    x = attack_x
    y = attack_y
    speed = 0
    ready_to_attack = 1
    sound = audio_play_sound_at(sou_underw_dec_b, x, y, 100, 50, 2500, 0.6, false, 0.4)
    audio_sound_gain_fx(sound, 0.6, 0)
    audio_sound_pitch(sound, (0.7 + random(0.6)))
}
warncol = lerp(warncol, warncol_target, 0.1)
size = lerp(size, size_target, 0.1)
image_xscale = (1 + (sin((time / 20)) * 0.1))
image_yscale = (1 / image_xscale)
image_xscale *= size
image_yscale *= size
tent1_angle += ((1 - image_xscale) * 2)
tent3_angle -= ((1 - image_xscale) * 2)
tent1_angle -= (hspeed * 0.4)
tent2_angle -= (hspeed * 0.4)
tent3_angle -= (hspeed * 0.4)
if (tent1_angle > -30)
    tent1_angle -= (vspeed * 0.2)
if (tent1_angle < 30)
    tent3_angle += (vspeed * 0.2)
tent1_angle *= 0.99
tent2_angle *= 0.99
tent3_angle *= 0.99
tent1_angle = clamp(tent1_angle, -90, 70)
tent2_angle = clamp(tent2_angle, -80, 80)
tent3_angle = clamp(tent3_angle, -70, 90)
if (random(120) < 1)
    image_speed = 1
