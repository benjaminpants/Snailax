scr_move_like_a_snail = function(argument0, argument1, argument2, argument3) //gml_Script_scr_move_like_a_snail
{
	multiplier = 1
	weight_multiplier = 1
	jump_multiplier = 1
	conveyor_multiplier = 1
	if (global.current_character == 1)
	{
		multiplier = 1.1
		weight_multiplier = 1.3
		jump_multiplier = 1.2
	}
	if (global.current_character == 2)
	{
		multiplier = 1.4
		conveyor_multiplier = 2
		jumpc_multiplier = 1
		jump_multiplier = 0.8
	}
	if (global.current_character == 3)
	{
		multiplier = 0.45
		weight_multiplier = 0.5
		jump_multiplier = 0.7
		conveyor_multiplier = 0
	}
    inputx = clamp(argument0, -1, 1)
    inputjump = argument1
    inputjumppress = argument2
    snailtype = argument3
    if underwater
    {
        if inbubble
            vspeed -= 0.05
        else if (vspeed < 0)
            vspeed += 0.25 * weight_multiplier
        else
            vspeed += 0.5 * weight_multiplier
        if (vspeed > 7 * weight_multiplier)
            vspeed = 7 * weight_multiplier
    }
    else if inbubble
    {
        vspeed -= 0.3
        vspeed *= 0.97
    }
    else
        vspeed += 1.5 * weight_multiplier
    water_current = collision_point(x, y, obj_underwater_current, 1, 1)
    timesincelastjump++
    if instance_exists(water_current)
    {
        hspeed += lengthdir_x(0.5, water_current.image_angle) * clamp(multiplier,1,99)
        vspeed += lengthdir_y(1.3, water_current.image_angle) * clamp(weight_multiplier,0.6,99)
        if (timesincelastjump < 30)
            vspeed *= (0.95 + (0.05 * abs(lengthdir_x(1, water_current.image_angle))))
        else
            vspeed *= 0.95
        if (snailtype == 0)
        {
            in_water_current = lerp(in_water_current, 1, 0.1)
            if (global.player_underwater_current_timer < 100)
                global.player_underwater_current_timer += 1
        }
    }
    else if (snailtype == 0)
    {
        in_water_current = lerp(in_water_current, 0, 0.05)
        if (global.player_underwater_current_timer > 0)
        {
            global.player_underwater_current_timer -= 0.3
            if (groundedremember > 0)
                global.player_underwater_current_timer -= 1
        }
    }
    if (vspeed < 0)
    {
        if (inputjump == 0)
        {
            if (inbubble == 0)
            {
                if (!global.save_fixed_jump_height)
                {
                    if underwater
                        vspeed += 0.5
                    else
                        vspeed += 2
                }
            }
        }
    }
    if underwater
    {
        hspeed += ((inputx * 0.45) * multiplier)
        hspeed *= 0.95
    }
    else if inbubble
    {
        hspeed += ((inputx * 0.4) * multiplier)
        hspeed *= 0.97
        hspeed = clamp(hspeed, -12, 12)
    }
    else
        hspeed = (inputx * 10) * multiplier
    if place_meeting(x, y, obj_conveyor_belt)
    {
        if (!underwater)
            hspeed += (global.conveyor_belt_speed * sign(global.conveyor_belt_direction)) * conveyor_multiplier
        else
            hspeed += ((global.conveyor_belt_speed * sign(global.conveyor_belt_direction)) * 0.1) * conveyor_multiplier
        if (snailtype == 0)
        {
            if (global.player_on_conveyor_timer <= 0)
                global.player_on_conveyor_timer = 1
            bonus_speed_by_conveyor = (global.conveyor_belt_speed * sign(global.conveyor_belt_direction)) * conveyor_multiplier
        }
    }
    groundedremember--
    jumpremember--
    if (place_free(x, (y + 10)) == 0)
    {
        groundedremember = 5
        airjumps = 1 * jumpc_multiplier
		hover_time = 120
        if (snailtype == 0)
        {
            global.input_analysis_performing_jump_timer = 0
            if (!(place_meeting(x, (y + 5), obj_conveyor_belt)))
                global.player_on_conveyor_timer = 0
        }
    }
    if inputjumppress
        jumpremember = 10
    if inbubble
    {
        if (jumpremember >= 0)
        {
            jumpremember = 1
            groundedremember = -1
            airjumps = 2 * jumpc_multiplier
			hover_time = 120
            inbubble = 0
            if (snailtype == 0)
            {
                sound = audio_play_sound(choose(5, 253), 0.8, false)
                audio_sound_gain_fx(sound, 0.75, 0)
                audio_sound_pitch(sound, (0.85 + random(0.3)))
                scr_exit_bubble()
            }
        }
    }
    if (groundedremember >= 0 || airjumps > 0)
    {
        if (jumpremember >= 0)
        {
            if (snailtype == 0)
            {
                if (global.input_analysis_performing_jump_timer <= 0)
                    global.input_analysis_performing_jump_timer = 1
                if global.underwater
                {
                    sound = audio_play_sound(choose(122, 123, 124, 125, 127, 128), 0.9, false)
                    audio_sound_gain_fx(sound, 1.2, 0)
                }
                else
                {
                    sound = audio_play_sound(choose(21, 22, 23, 24, 25, 26), 0.9, false)
                    audio_sound_gain_fx(sound, 0.2, 0)
                }
                if (random(1) < 0.5)
                {
                    if audio_is_playing(snail_voice_sound)
                        audio_stop_sound(snail_voice_sound)
                    if (!global.underwater)
                    {
                        snail_voice_sound = audio_play_sound(choose(63, 64, 65, 66, 67, 68, 69), 0.9, false)
                        audio_sound_gain_fx(snail_voice_sound, 0.05, 0)
                        audio_sound_pitch(snail_voice_sound, (0.45 + random(0.1)))
                    }
                    else
                    {
                        snail_voice_sound = audio_play_sound(choose(178, 179, 180, 181, 182, 184, 185), 0.9, false)
                        audio_sound_gain_fx(snail_voice_sound, 0.35, 0)
                        audio_sound_pitch(snail_voice_sound, (0.45 + random(0.1)))
                    }
                }
                if (groundedremember < 0)
                {
                    airjumps--
                    audio_sound_gain_fx(sound, 0.4, 0)
                    audio_sound_pitch(sound, 1.25)
                }
                else
                    timesincelastjump = 0
            }
            else if (groundedremember < 0)
                airjumps--
            jumpremember = -1
            groundedremember = -1
			vspeed = -25 * jump_multiplier
            if (snailtype == 0)
            {
                if (gun_equipped == 1)
                {
                    gun_cooldown = 5
                    idmerk = instance_create_layer((x - (lookdir * 13)), y, "Player", obj_sh_projectile)
                    idmerk.vspeed -= 20
                    idmerk.hspeed = 2
                    idmerk = instance_create_layer((x - (lookdir * 13)), y, "Player", obj_sh_projectile)
                    idmerk.vspeed -= 20
                    idmerk.hspeed = 4
                    idmerk = instance_create_layer((x - (lookdir * 13)), y, "Player", obj_sh_projectile)
                    idmerk.vspeed -= 20
                    idmerk.hspeed = -2
                    idmerk = instance_create_layer((x - (lookdir * 13)), y, "Player", obj_sh_projectile)
                    idmerk.vspeed -= 20
                    idmerk.hspeed = -4
                    if global.underwater
                        sound = audio_play_sound(sou_UnderwPop_04, 0.9, false)
                    else
                        sound = audio_play_sound(sou_shooter_plop_04, 0.9, false)
                    audio_sound_gain_fx(sound, 1, 0)
                }
                else if (gun_equipped == 2)
                {
                    gun_cooldown = 5
                    for (vsp = -5; vsp <= 5; vsp += 10)
                    {
                        idmerk = instance_create_layer((x - (lookdir * 13)), (y - 10), "Player", obj_sh_projectile)
                        idmerk.hspeed = (26 * lookdir)
                        old_yscale = idmerk.image_yscale
                        idmerk.image_yscale = idmerk.image_xscale
                        idmerk.image_xscale = old_yscale
                        idmerk.vspeed = vsp
                        idmerk.rotated = 1
                    }
                    if global.underwater
                        sound = audio_play_sound(sou_UnderwPop_04, 0.9, false)
                    else
                        sound = audio_play_sound(sou_shooter_plop_04, 0.9, false)
                    audio_sound_gain_fx(sound, 1, 0)
                }
                else if (gun_equipped == 3)
                {
                    if (airjumps == 0)
                    {
                        gun_cooldown = 5
                        idmerk = instance_create_layer((x - (lookdir * 13)), y, "Player", obj_sh_projectile)
                        idmerk.vspeed = 20
                        idmerk.hspeed = 2
                        idmerk = instance_create_layer((x - (lookdir * 13)), y, "Player", obj_sh_projectile)
                        idmerk.vspeed = 20
                        idmerk.hspeed = 4
                        idmerk = instance_create_layer((x - (lookdir * 13)), y, "Player", obj_sh_projectile)
                        idmerk.vspeed = 20
                        idmerk.hspeed = -2
                        idmerk = instance_create_layer((x - (lookdir * 13)), y, "Player", obj_sh_projectile)
                        idmerk.vspeed = 20
                        idmerk.hspeed = -4
                        if global.underwater
                            sound = audio_play_sound(sou_UnderwPop_04, 0.9, false)
                        else
                            sound = audio_play_sound(sou_shooter_plop_04, 0.9, false)
                        audio_sound_gain_fx(sound, 1, 0)
                    }
                }
            }
            if underwater
            {
                vspeed = -11 * jump_multiplier
                if (snailtype == 0)
                {
                    if (global.setting_visual_details > 0)
                    {
                        repeat (5)
                            part_particles_create(global.part_sys_fx, ((x - random(40)) + 20), ((y - random(20)) + 20), global.part_type_underwBubbles, 1)
                    }
                }
            }
            if (snailtype == 0)
            {
                idmerk = instance_create_layer(x, (y + 20), "Fx", obj_fx_flare)
                idmerk.decay = 0.8
                idmerk.image_blend = obj_levelstyler.col_player_trail
                idmerk.image_xscale = 0.25
                idmerk.image_yscale = 0.25
                idmerk.vspeed = 8
                idmerk = instance_create_layer(x, (y + 20), "Fx", obj_fx_flare)
                idmerk.decay = 0.9
                idmerk.image_blend = obj_levelstyler.col_player_trail
                idmerk.image_xscale = 0.25
                idmerk.image_yscale = 0.25
                idmerk.vspeed = 3
                idmerk = instance_create_layer(x, (y + 20), "Fx", obj_fx_flare)
                idmerk.decay = 0.95
                idmerk.image_blend = obj_levelstyler.col_player_trail
                idmerk.image_xscale = 0.25
                idmerk.image_yscale = 0.25
                idmerk.vspeed = 0
            }
        }
    }
    
	if (global.current_character == 2 and airjumps == 0 and hover_time > 0)
	{
		if (inputjump)
		{
			hover_time--
			if (underwater)
			{
				vspeed = -4
			}
			else
			{
				vspeed = -6
			}
		}
	}
	if (place_free((x + hspeed), y) == 0)
    {
        if (snailtype == 0 || simulte_movements_on_ramps)
        {
            if (place_free((x + hspeed), (y - 10)) && (!(place_free(x, (y + 5)))))
            {
                y -= 10
                x += hspeed
                move_contact_solid(270, -1)
                x -= hspeed
                vspeed = min(vspeed, 0)
            }
            else
            {
                if (hspeed > 0)
                    move_contact_solid(0, -1)
                else
                    move_contact_solid(180, -1)
                hspeed = 0
            }
        }
        else
        {
            if (hspeed > 0)
                move_contact_solid(0, -1)
            else
                move_contact_solid(180, -1)
            hspeed = 0
        }
    }
    if (place_free(x, (y + vspeed)) == 0)
    {
        if (vspeed > 0)
        {
            if (snailtype == 0)
            {
                if (vspeed > 7)
                {
                    if global.underwater
                        sound = audio_play_sound(choose(134, 135, 136), 0.7, false)
                    else
                        sound = audio_play_sound(choose(35, 36, 37), 0.7, false)
                    vol = (clamp(((vspeed - 7) * 0.03), 0, 0.5) * 0.75)
                    audio_sound_gain_fx(sound, (vol * vol), 0)
                    audio_sound_pitch(sound, (0.8 + (vol * 0.4)))
                    if (vspeed > 35)
                        gamepad_rumble = max(gamepad_rumble, 0.2)
                }
            }
            move_contact_solid(270, -1)
        }
        else if inbubble
        {
            if (snailtype == 0)
            {
                sound = audio_play_sound(choose(5, 253), 0.8, false)
                audio_sound_gain_fx(sound, 0.75, 0)
                audio_sound_pitch(sound, (2 + random(0.2)))
                scr_exit_bubble()
            }
            inbubble = 0
            airjumps = 1 * jumpc_multiplier
			hover_time = 120
        }
        else
        {
            move_contact_solid(90, -1)
            if (snailtype == 0)
            {
                if global.underwater
                {
                    sound = audio_play_sound(choose(3, 0, 16), 0.2, false)
                    audio_sound_gain_fx(sound, (abs(vspeed) / 18), 0)
                    audio_sound_pitch(sound, (0.85 + random(0.3)))
                }
                else
                {
                    sound = audio_play_sound(choose(331, 13, 6), 0.2, false)
                    audio_sound_gain_fx(sound, (abs(vspeed) / 120), 0)
                    audio_sound_pitch(sound, (1.7 + random(0.3)))
                }
                if (global.setting_visual_details >= 2)
                {
                    repeat round(abs((vspeed / 4)))
                        part_particles_create(global.part_sys_fx, ((x - random(20)) + 10), (y - 20), global.part_type_ceilingTouch, 1)
                }
            }
        }
        vspeed = 0
    }
    if (place_free((x + hspeed), (y + vspeed)) == 0)
        hspeed = 0
    return;
}

