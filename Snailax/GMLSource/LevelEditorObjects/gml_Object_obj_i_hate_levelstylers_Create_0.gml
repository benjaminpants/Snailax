//no.
ds_list_clear(global.last_deaths_position)
laser_switch_cooldown = 0
global.underwater = 0
underwater = 0
color_scheme_backup = global.setting_color_scheme
difficulty_backup = global.save_difficulty
difficulty_set_by_ai = global.save_difficulty
squid_muted_backup = (global.setting_volue_voice <= 0 || global.setting_volume_master <= 0)
time_backup = current_time
alarm[0] = 1
alarm[1] = 1
glitchy = 0
random_set_seed(random(100000))
lay = layer_get_id("BackPatterns")
enable_back_particle_spawn = 0
str_load_colors = ""
col_snail_outline = make_color_rgb(18, 20, 66)
col_snail_body = make_color_rgb(60, 92, 153)
col_snail_shell = make_color_rgb(70, 108, 178)
col_snail_eye = make_color_rgb(183, 184, 229)
col_smiley_1 = 32768
col_smiley_2 = 32768
col_player_spotlight = make_color_rgb(0, 5, 20)
col_player_spotlight_dark = 0
background_size_min = 1
background_size_max = 1
background_style = 0
background_parallax_min = 0.25
background_parallax_max = 0.5
background_scroll_speed = 1
background_scroll_speed_min = 0.5
global.walls_brightness_when_lights_are_out = 0.7
global.col_disco_light_hue_offset = 0
global.col_disco_light_hue_spread = 50
global.col_disco_light_saturation = 155
global.col_disco_light_alpha = 0.3
global.col_lvlselect_lvl_locked_front = make_color_rgb(50, 50, 50)
global.col_lvlselect_lvl_locked_back = make_color_rgb(25, 25, 25)
global.col_lvlselect_lvl_normal_front = make_color_rgb(255, 100, 0)
global.col_lvlselect_lvl_normal_back = make_color_rgb(255, 255, 100)
global.col_lvlselect_lvl_story_front = 16711680
global.col_lvlselect_lvl_story_back = make_color_rgb(150, 150, 255)
global.col_lvlselect_lvl_secret_front = make_color_rgb(200, 20, 100)
global.col_lvlselect_lvl_secret_back = make_color_rgb(180, 120, 20)
global.col_lvlselect_moretoexplore_arrow = make_color_rgb(255, 255, 25)
global.col_lvlselect_moretoexplore_arrow_selected = 65535
color_rotation_allowed = 1
minimalist_color_mode = 0
event_user(0)
event_user(2)
scr_split_walls()
scr_create_wall_lines()
global.glitchA = 0
time = 0
global.levelstyler_colors_need_to_be_reloaded = 0
