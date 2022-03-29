if (not instance_exists(obj_player))
{
	image_blend = obj_levelstyler.col_traps
	return false;
}
vspeed += gravityy
if (abs((x - obj_player.x)) < activation_range && abs((y - obj_player.y)) < 600)
{
    sprite_index = spr_enemy
    image_blend = merge_color(obj_levelstyler.col_traps, c_white, 0)
    if (y > obj_player.y)
    {
        if (random(jump_probability) < 1)
        {
            if (random(1) < 0.3)
                vspeed = ((-jump_force) * (random(0.5) + 0.5))
            else
                vspeed = (-jump_force)
            idmerk = instance_create_layer(x, (y + 20), "Fx", obj_fx_flare)
            idmerk.decay = 0.8
            idmerk.image_blend = image_blend
            idmerk.image_xscale = 0.25
            idmerk.image_yscale = 0.25
            idmerk.vspeed = 8
            idmerk = instance_create_layer(x, (y + 20), "Fx", obj_fx_flare)
            idmerk.decay = 0.9
            idmerk.image_blend = image_blend
            idmerk.image_xscale = 0.25
            idmerk.image_yscale = 0.25
            idmerk.vspeed = 3
            idmerk = instance_create_layer(x, (y + 20), "Fx", obj_fx_flare)
            idmerk.decay = 0.95
            idmerk.image_blend = image_blend
            idmerk.image_xscale = 0.25
            idmerk.image_yscale = 0.25
            idmerk.vspeed = 0
            sound = audio_play_sound_at(choose(21, 22, 23, 24, 25, 26), x, y, 0, 500, 800, 0.1, false, 0.4)
            audio_sound_gain_fx(sound, 0.2, 0)
            audio_sound_pitch(sound, 2)
        }
    }
    hspeed = 0
    if (abs((x - obj_player.x)) < 200)
    {
        move_timer--
        if (move_timer <= 0)
        {
            if (abs((obj_player.x - x)) > 10)
                hspeed = (sign((obj_player.x - x)) * movespeed)
        }
    }
    if (last_active == 0)
    {
        aw_target_xscale_speed = -0.3
        sound = audio_play_sound_at(sou_order_beep, x, y, 0, 500, 800, 0.1, false, 0.5)
        audio_sound_gain_fx(sound, 0.5, 0)
        audio_sound_pitch(sound, (2 + random(0.2)))
    }
    last_active = 1
}
else
{
    sprite_index = spr_enemy_standby
    image_blend = merge_color(obj_levelstyler.col_wall_outline, c_black, 0.4)
    if (last_active == 1)
    {
        aw_target_xscale_speed = 0.1
        sound = audio_play_sound_at(sou_order_beep, x, y, 0, 500, 800, 0.1, false, 0.5)
        audio_sound_gain_fx(sound, 0.5, 0)
        audio_sound_pitch(sound, (1.5 + random(0.15)))
    }
    last_active = 0
}
scr_dont_move_through_walls()
scr_autowhobble_update()
