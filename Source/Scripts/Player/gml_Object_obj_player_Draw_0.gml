if underwater
{
    if (airjumps > 0 && groundedremember < 5)
        bubbleindicator = lerp(bubbleindicator, 1, 0.1)
    else
        bubbleindicator = lerp(bubbleindicator, 0, 0.2)
    if (bubbleindicator >= 0.02)
    {
        bblsize = ((0.5 + (sin((time * 0.1)) * 0.05)) * bubbleindicator)
        draw_sprite_ext(spr_bubble, image_index, x, ((y + 15) + (15 * bblsize)), bblsize, bblsize, house_tilt, image_blend, 1)
        bblsize = ((0.5 + (sin(((time * 0.08) + 34)) * 0.05)) * bubbleindicator)
        draw_sprite_ext(spr_bubble, image_index, (x - 20), ((y + 15) + (15 * bblsize)), bblsize, bblsize, house_tilt, image_blend, 1)
        bblsize = ((0.5 + (sin(((time * 0.085) + 15.3)) * 0.05)) * bubbleindicator)
        draw_sprite_ext(spr_bubble, image_index, (x + 20), ((y + 15) + (15 * bblsize)), bblsize, bblsize, house_tilt, image_blend, 1)
    }
}
house_height = lerp(house_height, (1 + (vspeed * 0.05)), 0.2)
house_height = clamp(house_height, 0.4, 1.6)
house_width = clamp((1 / house_height), 0.8, 5)
house_tilt = lerp(house_tilt, hspeed, 0.1)
house_sprite = spr_snail_house
if (global.current_character == 0)
{
	if (gun_equipped == 1)
		house_sprite = spr_snail_house_gun
	if (gun_equipped == 2)
		house_sprite = spr_snail_house_gun2
	if (gun_equipped == 3)
		house_sprite = spr_snail_house_gun3
	if (gun_equipped == 4)
		house_sprite = 74
	draw_sprite_ext(house_sprite, 0, (x - (15 * lookdir)), (y + 16), (house_width * lookdir), house_height, house_tilt, col_snail_shell, 1)
	draw_sprite_ext(house_sprite, 1, (x - (15 * lookdir)), (y + 16), (house_width * lookdir), house_height, house_tilt, col_snail_outline, 1)
	draw_sprite_ext(spr_player_base, 0, x, y, (image_xscale * lookdir), image_yscale, image_angle, col_snail_body, 1)
	draw_sprite_ext(spr_player_base, 1, x, y, (image_xscale * lookdir), image_yscale, image_angle, col_snail_outline, 1)
}
if (global.current_character == 1)
{
	var sprite_to_draw = spr_player1
    if (vspeed < 0)
    {
        sprite_to_draw = spr_player_down1
    }
    else if (vspeed > 0)
    {
        sprite_to_draw = spr_player_up1
    }
    draw_sprite_ext(sprite_to_draw,0,x,y , lookdir, 1, 0, c_white, 1)
}
if (global.current_character == 2)
{
	draw_sprite_ext(spr_evil_snail_inside,0,x, y + 25 , (lookdir * aw_OUT_xscale), (image_yscale * aw_OUT_yscale), (image_angle + aw_OUT_angle), col_snail_shell, 1)
    draw_sprite_ext(spr_evil_snail,0,x,y + 25 , (lookdir * aw_OUT_xscale), (image_yscale * aw_OUT_yscale), (image_angle + aw_OUT_angle), col_snail_outline, 1)
}
if (global.current_character == 3)
{
	draw_sprite_ext(spr_player_base,0,x, y, (lookdir * aw_OUT_xscale), (image_yscale * aw_OUT_yscale), (image_angle + aw_OUT_angle), col_snail_body, 1)
    draw_sprite_ext(spr_player_base,0,x,y, (lookdir * aw_OUT_xscale), (image_yscale * aw_OUT_yscale), (image_angle + aw_OUT_angle), col_snail_outline, 1)
}

if inbubble
{
	inbubble_flash = max(0, (inbubble_flash - 0.025))
	inbubble_whobble = ((1 + ((sin((inbubble_flash * 30)) * 0.3) * inbubble_flash)) + (abs((speed * 0.01)) * (1 - inbubble_flash)))
	draw_sprite_ext(spr_bubblewubble, 0, (x + lengthdir_x(((-speed) * 0.7), direction)), (y + lengthdir_y(((-speed) * 0.7), direction)), ((1 * inbubble_whobble) + (inbubble_flash * 0.3)), ((1 / inbubble_whobble) + (inbubble_flash * 0.3)), direction, obj_levelstyler.col_bubbles, 1)
	if (abs((hspeed - hspeed_last)) > 2)
	{
		inbubble_flash += ((abs((hspeed - hspeed_last)) - 2) * 0.1)
		inbubble_flash = clamp(inbubble_flash, 0, 1)
	}
	hspeed_last = hspeed
}