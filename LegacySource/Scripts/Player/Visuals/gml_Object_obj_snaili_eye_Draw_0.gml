if (global.current_character == 0)
{
	draw_sprite_ext(spr_snail_eye_connection, 0, xconnection, yconnection, (dist / 11), 1, dir, col_snail_body, 1)
	draw_sprite_ext(spr_snail_eye_connection, 1, xconnection, yconnection, (dist / 11), 1, dir, col_snail_outline, 1)
	draw_sprite_ext(spr_snail_eye, 0, x, y, image_xscale, image_yscale, 0, col_snail_eye, 1)
	draw_sprite_ext(spr_snail_eye, 1, x, y, image_xscale, image_yscale, 0, col_snail_outline, 1)
	draw_sprite_ext(spr_snail_pupil, 0, (x + (look_lerp_x * 2)), (y + (look_lerp_y * 5)), 1, 1, 0, col_snail_outline, 1)

}