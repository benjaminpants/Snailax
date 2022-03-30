scr_draw_subtitle = function(argument0, argument1, argument2)
{
    if ((!instance_exists(obj_player)) and room != snailax_editor_room)
        return;
    draw_set_font(global.font_aiTalk)
    draw_set_halign(fa_center)
    draw_set_valign(fa_middle)
    maxheight = display_get_gui_height()
    subtitle_pos_x = (display_get_gui_width() / 2)
    subtitlesize = (global.setting_subtitle_size * 0.9)
    fontsize = subtitlesize
    maxwidth = (lerp(1300, 1900, (subtitlesize / 2)) / subtitlesize)
    dist = (4 * subtitlesize)
    txtheight = (gml_Script_arab_string_height_ext(argument0, -1, maxwidth) * subtitlesize)
    mindist = ((txtheight * 0.5) + 60)
    if (global.setting_subtitles == 3)
    {
        if (room == AngerManagementRoom || !instance_exists(obj_player))
			yypos = 1
        else
        {
            camHeight = camera_get_view_height(view_camera[0])
            camY = camera_get_view_y(view_camera[0])
            subTitleHeight = (((txtheight + 70) * camHeight) / maxheight)
            playeryy = obj_player.y
            if (obj_player.dead == -1)
            {
                if (obj_player.victory == -1)
                {
                    if (obj_player.active_time > 30)
                    {
                        if (global.auto_subtitle_target_pos == 1)
                        {
                            if (playeryy > ((camY + camHeight) - subTitleHeight))
                                global.auto_subtitle_target_pos = 2
                        }
                        else if (global.auto_subtitle_target_pos == 2)
                        {
                            if (playeryy < (camY + subTitleHeight))
                                global.auto_subtitle_target_pos = 1
                        }
                    }
                }
            }
            if (global.auto_subtitle_target_pos == 1)
                yypos = 1
            else
                yypos = 0
        }
    }
    else if (global.setting_subtitles == 1)
        yypos = 1
    else
        yypos = 0
		
	if (!instance_exists(obj_player))
	{
		yypos = 1
	}
    subtitle_pos_y = (maxheight * yypos)
    subtitle_pos_y = clamp(subtitle_pos_y, mindist, (maxheight - mindist))
    draw_set_color(c_black)
    gml_Script_arab_draw_text_ext_transformed((subtitle_pos_x + dist), subtitle_pos_y, argument0, -1, maxwidth, fontsize, fontsize, 0)
    gml_Script_arab_draw_text_ext_transformed((subtitle_pos_x - dist), subtitle_pos_y, argument0, -1, maxwidth, fontsize, fontsize, 0)
    gml_Script_arab_draw_text_ext_transformed(subtitle_pos_x, (subtitle_pos_y - dist), argument0, -1, maxwidth, fontsize, fontsize, 0)
    gml_Script_arab_draw_text_ext_transformed(subtitle_pos_x, (subtitle_pos_y + dist), argument0, -1, maxwidth, fontsize, fontsize, 0)
    gml_Script_arab_draw_text_ext_transformed((subtitle_pos_x + dist), (subtitle_pos_y + dist), argument0, -1, maxwidth, fontsize, fontsize, 0)
    gml_Script_arab_draw_text_ext_transformed((subtitle_pos_x - dist), (subtitle_pos_y + dist), argument0, -1, maxwidth, fontsize, fontsize, 0)
    gml_Script_arab_draw_text_ext_transformed((subtitle_pos_x + dist), (subtitle_pos_y - dist), argument0, -1, maxwidth, fontsize, fontsize, 0)
    gml_Script_arab_draw_text_ext_transformed((subtitle_pos_x - dist), (subtitle_pos_y - dist), argument0, -1, maxwidth, fontsize, fontsize, 0)
    draw_set_color(argument1)
    gml_Script_arab_draw_text_ext_transformed(subtitle_pos_x, subtitle_pos_y, argument0, -1, maxwidth, fontsize, fontsize, 0)
    return;
}

