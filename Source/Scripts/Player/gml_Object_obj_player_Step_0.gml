if keyboard_check_pressed(vk_f2)
{
    room_restart()
}
audio_listener_position(x, y, 0)
if underwater
{
    target_vol = (in_water_current * lerp(0.9, 0.6, clamp((speed * 0.08), 0, 1)))
    target_vol += clamp(((speed - 12) * 0.1), 0, 1)
    target_vol = clamp(target_vol, 0, 1)
    wind_sound_fall_volume = lerp(wind_sound_fall_volume, target_vol, 0.1)
    audio_sound_gain_fx(wind_sound_fall, ((wind_sound_fall_volume * wind_sound_fall_volume) * 0.8), 0.016666666666666666)
    audio_sound_pitch(wind_sound_fall, (1 + (wind_sound_fall_volume * 0.1)))
    if (speed > 10)
    {
        bubbleamount = clamp(((speed - 10) / 4), 0, 1)
        if (random(1) < ((0.5 * bubbleamount) * scr_particle_multiplyer()))
            part_particles_create(global.part_sys_fx, ((x - random(20)) + 10), ((y - random(20)) + 10), global.part_type_underwBubbles, 1)
    }
}
else
{
    wind_sound_fall_volume = lerp(wind_sound_fall_volume, clamp(((abs(speed) - 10) * 0.1), 0, 1), 0.1)
    audio_sound_gain_fx(wind_sound_fall, ((wind_sound_fall_volume * wind_sound_fall_volume) * 0.9), 0.016666666666666666)
}
lookdir_smooth = lerp(lookdir_smooth, lookdir, 0.15)
realhspeed = (hspeed - bonus_speed_by_conveyor)
slither_active = (vspeed == (0 * realhspeed) * 0.2)
if (round(hspeed) != 0)
{
	wind_sound_slither_volume = lerp(wind_sound_slither_volume, slither_active, 0.5)
}
else
{
	wind_sound_slither_volume = 0
}
audio_sound_gain_fx(wind_sound_slither, ((wind_sound_slither_volume * wind_sound_slither_volume) * 0.8), 0.016666666666666666)
if (reading_file == -1)
{
    override_lookdir = 0
    with (obj_persistent)
        event_user(0)
    with (obj_input_overrider_parent)
        event_user(0)
}
if (global.input_jump && (!global.input_jump_pressed) && global.input_x == 0 && reading_file == -1)
{
    if (groundedremember > 0)
        holding_jump_without_moving_timer += 1
}
else
{
    glitch_mode_and_dir = -1
    holding_jump_without_moving_timer = 0
}
if (holding_jump_without_moving_timer > 120)
{
    if (glitch_mode_and_dir == -1)
    {
        free_right = place_free((x + 25), y)
        free_left = place_free((x - 25), y)
        free_top = place_free(x, (y - 25))
        free_bot = place_free(x, (y + 25))
        if ((!free_right) && (!free_left) && (!free_bot))
            glitch_mode_and_dir = 90
        else if ((!free_top) && (!free_bot) && (!free_left))
            glitch_mode_and_dir = 0
        else if ((!free_top) && (!free_bot) && (!free_right))
            glitch_mode_and_dir = 180
        if (glitch_mode_and_dir != -1)
        {
            scr_set_achievement("GLITCH_IT")
            global.voice_lines_override = 0
            with (obj_aivl_package_parent)
                event_user(2)
            if (!global.voice_lines_override)
            {
                if (!(aivl_play("using_glitch_first_time", 3)))
                {
                    if (!(aivl_play("using_glitch_2nd_time", 2)))
                    {
                        if (!(aivl_play("using_glitch_3rd_time", 1)))
                            aivl_play("using_glitch_4th_time", 1)
                    }
                }
            }
        }
    }
}
if (glitch_mode_and_dir >= 0)
{
    if (global.player_using_glitch_timer < 120)
        global.player_using_glitch_timer += 1
    holding_jump_without_moving_timer = 0
    groundedremember = -1
    airjumps = 1
    motion_set(glitch_mode_and_dir, 20)
    scr_dont_move_through_walls()
    part_particles_create(global.part_sys_fxPlayer, ((x - 30) + random(60)), ((y + 10) + random(20)), global.part_type_zeroOne, 1)
    sound = audio_play_sound(sou_boink_a, 0.01, false)
    audio_sound_gain_fx(sound, 0.2, 0)
    audio_sound_pitch(sound, (2 + random(2)))
    if (speed <= 0)
        glitch_mode_and_dir = -1
}
else if (global.player_using_glitch_timer > 0)
    global.player_using_glitch_timer -= 1
if (global.input_reset && allow_restarts)
{
    if (!instance_exists(obj_performance_optimizer))
    {
        if (!instance_exists(obj_fix_heart_decision))
        {
            if (!instance_exists(obj_reset_squid_decision))
            {
                if (victory == -1 && dead == -1)
                {
                    if (lockmovement <= 0)
                    {
                        global.last_death_by = -7
                        global.last_death_by_hspeed = 0
                        global.last_death_by_vspeed = 0
                        global.last_death_by_image_anlge = 0
                        scr_player_death((obj_player.direction + 180), 0)
                        dead = 30
                        global.save_speedrun_timer_level = 0
                    }
                }
            }
        }
    }
}
lockmovement--
if (lockmovement > 0)
{
    global.input_x = 0
    global.input_jump = 0
    global.input_jump_pressed = 0
}
nomovement_timer++
if (nomovement_timer >= 600)
    nomovement_timer = 0
particletraveldist += point_distance(x, y, xlast, ylast)
while (particletraveldist > 5)
{
    particletraveldist -= 5
    xxp = lerp(x, xlast, random(1))
    yyp = lerp(y, ylast, random(1))
    if (global.setting_visual_details != 0)
    {
        part_type_direction(global.part_type_playerTrail, (direction - 20), (direction + 20), 0, 0)
        part_type_speed(global.part_type_playerTrail, 0, (speed * 0.02), 0, 0)
        part_particles_create(global.part_sys_fxPlayer, ((xxp - 3) + random(6)), ((yyp - 3) + random(6)), global.part_type_playerTrail, 1)
        if speedboosted
        {
            part_type_size(global.part_type_deathBounce, 0.2, 0.3, 0, 0)
            part_particles_create(global.part_sys_fxPlayer, ((xxp - 3) + random(6)), ((yyp - 3) + random(6)), global.part_type_deathBounce, 1)
        }
    }
}
bonus_speed_by_conveyor = 0
if (dead < 0 && victory < 0)
{
    if (glitch_mode_and_dir < 0)
    {
        if (reading_file == -1)
        {
            if global.language_testing_mode
                airjumps = 1
            if (!override_lookdir)
            {
                if (global.input_x > 0)
                    lookdir = 1
                else if (global.input_x < 0)
                    lookdir = -1
            }
            scr_move_like_a_snail(global.input_x, global.input_jump, global.input_jump_pressed, 0)
        }
        else
            scr_move_like_a_snail(0, 0, 0, 0)
        if speedboosted
        {
            if (abs(hspeed) < 1)
            {
                speedboosted_grace_period--
                if (speedboosted_grace_period <= 0)
                    speedboosted = 0
            }
            else
            {
                speedboosted_grace_period = 6
                if global.underwater
                    hspeed += (global.input_x * 1)
                else
                    hspeed += (sign(hspeed) * 12)
                scr_dont_move_through_walls()
            }
        }
        if extra_speed_mode
        {
            if (reading_file == -1)
            {
                hspeed_prev = (x - xlast)
                if (hspeed > 0)
                {
                    if (hspeed_prev > 0)
                    {
                        if (global.input_x >= 0.9)
                            hspeed = (max(hspeed, hspeed_prev) + 0.01)
                    }
                }
                if (hspeed > 11)
                    hspeed += 0.1
                if (hspeed < 0)
                {
                    if (hspeed_prev < 0)
                    {
                        if (global.input_x <= -0.9)
                            hspeed = (min(hspeed, hspeed_prev) - 0.01)
                    }
                }
                if (hspeed < -11)
                    hspeed -= 0.1
                hspeed = clamp(hspeed, -20, 20)
                scr_dont_move_through_walls()
            }
        }
    }
}
else if (victory >= 0)
{
    if instance_exists(obj_destroyed_boss_parent)
    {
        scr_move_like_a_snail(0, 0, 0, 0)
        speed *= 0.9
    }
    else
        speed = 0
}
else
    speed = 0
if (dead >= 0)
{
    speed = 0
    dead++
    if (dead >= 40)
        scr_room_reset()
}
if (victory >= 0)
{
    victory++
    if (victory >= 15)
    {
        if (!instance_exists(obj_destroyed_boss_parent))
        {
            idcollision = collision_point(x, y, obj_go_to_room, 0, 1)
            if global.save_speedrun_training_mode
            {
                if instance_exists(idcollision)
                {
                    if (idcollision.object_index == obj_go_to_lvl_select)
                        scr_fade_to_room_ext(idcollision.go_to_room, idcollision.is_shortcut)
                }
                scr_fade_to_room(room)
            }
            if instance_exists(idcollision)
                scr_fade_to_room_ext(idcollision.go_to_room, idcollision.is_shortcut)
            else
                scr_fade_to_room(room_next(room))
        }
    }
}
xlast = x
ylast = y
if (speed > 0)
    nomovement_timer = 0
if (gun_equipped > 0)
{
    gun_cooldown--
    if (gun_cooldown <= 0)
    {
        if (dead == -1)
        {
            gun_cooldown = 5
            if (gun_equipped == 1)
            {
                idmerk = instance_create_layer((x - (lookdir * 13)), (y - 10), "Player", obj_sh_projectile)
                idmerk.vspeed -= 20
                with (obj_hat_parent)
                    event_user(1)
            }
            else if (gun_equipped == 2)
            {
                idmerk = instance_create_layer((x - (lookdir * 13)), (y - 10), "Player", obj_sh_projectile)
                idmerk.hspeed = (26 * lookdir)
                old_yscale = idmerk.image_yscale
                idmerk.image_yscale = idmerk.image_xscale
                idmerk.image_xscale = old_yscale
                idmerk.rotated = 1
            }
            else if (gun_equipped == 3)
            {
                idmerk = instance_create_layer((x - (lookdir * 13)), (y - 10), "Player", obj_sh_projectile)
                idmerk.vspeed = 20
            }
            else if (gun_equipped == 4)
            {
                if instance_exists(obj_boss_p2)
                {
                    idmerk = instance_create_layer((x - (lookdir * 13)), (y - 10), "Player", obj_sh_projectile)
                    idmerk.direction = point_direction(x, y, obj_boss_p2.x, obj_boss_p2.y)
                    idmerk.image_angle = idmerk.direction
                    idmerk.speed = 20
                    idmerk.image_xscale = 0.2
                    idmerk.image_yscale = 0.2
                }
            }
        }
    }
}
if (global.player_on_conveyor_timer > 0)
    global.player_on_conveyor_timer += 1
time++
if (global.input_analysis_idle_timer == 1200)
{
    if (room == T_01_first_contact)
    {
        if aivl_has_played("tutorialB_intro")
            aivl_play("idle_in_very_first_room", 3)
    }
    lvltype = scr_level_dat_get_type(room)
    if (lvltype != 0)
    {
        if (lvltype != 1)
        {
            if (lvltype != 3)
            {
                if (lvltype != 5)
                {
                    if (!instance_exists(obj_destroyed_boss_parent))
                        aivl_play_random("idle", 2, 3)
                }
            }
        }
    }
}
if (global.input_analysis_idle_timer == 120)
{
    lvltype = scr_level_dat_get_type(room)
    if (lvltype != 1)
    {
        if (lvltype != 3)
        {
            if (!(place_free(x, (y + 2))))
            {
                if (place_free((x - 11), (y + 2)) || place_free((x + 11), (y + 2)))
                {
                    if (!instance_exists(obj_destroyed_boss_parent))
                    {
                        if (room != X_11_boss_P1)
                        {
                            if (room != X_12_boss_P2)
                            {
                                if instance_exists(obj_ai_general)
                                {
                                    if obj_ai_general.enabled
                                    {
                                        if (!obj_ai_general.setting_combletely_disabled)
                                        {
                                            if (obj_ai_general.setting_ground_spike_probability > 0 || obj_ai_general.setting_wall_spike_probability > 0 || obj_ai_general.setting_ceiling_spike_probability > 0)
                                            {
                                                if (obj_ai_general.setting_air_cat_probability <= 0)
                                                {
                                                    if (obj_ai_general.setting_badball_probability <= 0)
                                                    {
                                                        if (obj_ai_general.setting_laser_probability <= 0)
                                                            aivl_play_random("safe_on_block_corner", 3, 2)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                aivl_play_random("standing_on_block_corner", 3, 2)
                            }
                        }
                    }
                }
            }
        }
    }
}
if (hspeed != 0)
    started_playing = 1
if started_playing
{
    if (global.input_analysis_idle_timer < 600)
        active_time++
}
