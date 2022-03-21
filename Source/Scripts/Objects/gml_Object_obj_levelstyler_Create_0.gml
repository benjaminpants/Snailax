if global.save_pump_is_inverted
{
    if (object_index == obj_levelstyler)
    {
        if (x > -1000)
        {
            if (room != SecretPump)
            {
                if (room != menu)
                {
                    if (room != main_menu_dark)
                    {
                        if (room != EndGameCredits)
                        {
                            if (room != disclaimer_photoepilepsy)
                            {
                                if (room != disclaimer_playtest)
                                {
                                    with (obj_player)
                                        underwater = 1
                                    with (obj_ai_general)
                                        underwater = 1
                                    instance_create_layer(-10000, 0, "Fx", obj_levelstyler_underwater)
                                    instance_destroy()
                                    return false;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
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
if layer_get_visible(lay)
    enable_back_particle_spawn = 1
if instance_exists(obj_levelstyler_winter)
    enable_back_particle_spawn = 0

//if (instance_exists(obj_level_editor))
//{
	//if (not obj_level_editor.being_destroyed)
	//{
		//enable_back_particle_spawn = 0
	//}
//}
	

if enable_back_particle_spawn
    instance_create_layer(0, 0, lay, obj_backdraw)
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
layBack = layer_background_get_id("OutsideRoom")
layer_background_blend(layBack, col_back)
global.glitchA = 0
if (room != menu)
{
    global.conveyor_belt_speed = scr_get_difficulty_conveyor_speed()
    global.part_sys_fxPlayer = part_system_create_layer("Fx_Player", 1)
    part_system_automatic_update(global.part_sys_fxPlayer, 0)
    global.part_sys_backPatterns = part_system_create_layer("BackPatterns", 1)
    part_system_automatic_update(global.part_sys_backPatterns, 0)
    global.part_sys_fx = part_system_create_layer("Fx", 1)
    part_system_automatic_update(global.part_sys_fx, 0)
    global.part_type_playerSparks = part_type_create()
    part_type_color_mix(global.part_type_playerSparks, col_snail_death, merge_color(col_snail_death, c_white, 0.5))
    part_type_life(global.part_type_playerSparks, 80, 150)
    part_type_alpha3(global.part_type_playerSparks, 1, 0.25, 0)
    part_type_sprite(global.part_type_playerSparks, 195, 0, 0, 1)
    part_type_speed(global.part_type_playerSparks, 0, 1, 0, 0)
    part_type_orientation(global.part_type_playerSparks, 0, 360, 0, 0, 0)
    part_type_direction(global.part_type_playerSparks, 0, 360, 0, 0)
    global.part_type_playerTrail = part_type_create()
    part_type_color1(global.part_type_playerTrail, col_player_trail)
    part_type_life(global.part_type_playerTrail, 50, 70)
    part_type_alpha3(global.part_type_playerTrail, 0.05, 0.03, 0)
    part_type_sprite(global.part_type_playerTrail, 199, 0, 0, 1)
    part_type_speed(global.part_type_playerTrail, 0.4, 0.6, 0, 0)
    part_type_orientation(global.part_type_playerTrail, 0, 360, 0, 0, 0)
    part_type_direction(global.part_type_playerTrail, 0, 360, 0, 0)
    part_type_size(global.part_type_playerTrail, 1.25, 1.25, 0, 0)
    global.part_type_enemyTrail = part_type_create()
    part_type_color1(global.part_type_enemyTrail, col_spike_warning)
    part_type_life(global.part_type_enemyTrail, 50, 70)
    part_type_alpha3(global.part_type_enemyTrail, 0.05, 0.03, 0)
    part_type_sprite(global.part_type_enemyTrail, 199, 0, 0, 1)
    part_type_speed(global.part_type_enemyTrail, 0.4, 0.6, 0, 0)
    part_type_orientation(global.part_type_enemyTrail, 0, 360, 0, 0, 0)
    part_type_direction(global.part_type_enemyTrail, 0, 360, 0, 0)
    part_type_size(global.part_type_enemyTrail, 1.25, 1.25, 0, 0)
    global.part_type_backPattern = part_type_create()
    part_type_color1(global.part_type_backPattern, col_back_pattern)
    part_type_life(global.part_type_backPattern, 9000, 9000)
    part_type_sprite(global.part_type_backPattern, 11, 0, 0, 1)
    part_type_direction(global.part_type_backPattern, 10, 80, 0, 0)
    part_type_speed(global.part_type_backPattern, 0.2, 0.4, 0, 0)
    global.part_type_shooterKill = part_type_create()
    part_type_color3(global.part_type_shooterKill, 16777215, col_traps, col_traps)
    part_type_life(global.part_type_shooterKill, 40, 40)
    part_type_alpha3(global.part_type_shooterKill, 1, 0.25, 0)
    part_type_sprite(global.part_type_shooterKill, 10, 0, 0, 1)
    part_type_speed(global.part_type_shooterKill, 9, 11, -0.3, 0)
    part_type_orientation(global.part_type_shooterKill, 0, 360, 0, 0, 0)
    part_type_direction(global.part_type_shooterKill, 0, 360, 0, 0)
    part_type_size(global.part_type_shooterKill, 0.25, 0.35, -0.01, 0)
    part_type_gravity(global.part_type_shooterKill, 0, 270)
    global.part_type_smilyCollect = part_type_create()
    part_type_color3(global.part_type_smilyCollect, 16777215, col_snail, col_wall_outline)
    part_type_life(global.part_type_smilyCollect, 40, 40)
    part_type_alpha3(global.part_type_smilyCollect, 1, 0.25, 0)
    part_type_sprite(global.part_type_smilyCollect, 10, 0, 0, 1)
    part_type_speed(global.part_type_smilyCollect, 9, 11, -0.3, 0)
    part_type_orientation(global.part_type_smilyCollect, 0, 360, 0, 0, 0)
    part_type_direction(global.part_type_smilyCollect, 0, 360, 0, 0)
    part_type_size(global.part_type_smilyCollect, 0.125, 0.175, -0.005, 0)
    part_type_gravity(global.part_type_smilyCollect, 0, 270)
    global.part_type_bossBrckerle = part_type_create()
    part_type_color1(global.part_type_bossBrckerle, col_traps)
    part_type_life(global.part_type_bossBrckerle, 600, 600)
    part_type_alpha3(global.part_type_bossBrckerle, 1, 1, 0)
    part_type_sprite(global.part_type_bossBrckerle, 214, 0, 0, 1)
    part_type_speed(global.part_type_bossBrckerle, 0, 1.5, 0, 0)
    part_type_orientation(global.part_type_bossBrckerle, 0, 360, 0, 0, 0)
    part_type_direction(global.part_type_bossBrckerle, 0, 360, 0, 0)
    part_type_size(global.part_type_bossBrckerle, 0.3, 1, 0, 0)
    part_type_gravity(global.part_type_bossBrckerle, 0.02, 270)
    global.part_type_bossKill = part_type_create()
    part_type_color3(global.part_type_bossKill, 16777215, col_traps, col_traps)
    part_type_life(global.part_type_bossKill, 60, 120)
    part_type_alpha3(global.part_type_bossKill, 1, 0.25, 0)
    part_type_sprite(global.part_type_bossKill, 10, 0, 0, 1)
    part_type_speed(global.part_type_bossKill, 9, 27, -0.3, 0)
    part_type_orientation(global.part_type_bossKill, 0, 360, 0, 0, 0)
    part_type_direction(global.part_type_bossKill, 0, 360, 0, 0)
    part_type_size(global.part_type_bossKill, 0.25, 1.25, -0.01, 0)
    part_type_gravity(global.part_type_bossKill, 0, 270)
    global.part_type_bubblePop = part_type_create()
    part_type_color3(global.part_type_bubblePop, 16777215, 16777215, 16777215)
    part_type_life(global.part_type_bubblePop, 40, 40)
    part_type_alpha3(global.part_type_bubblePop, 1, 0.25, 0)
    part_type_sprite(global.part_type_bubblePop, 10, 0, 0, 1)
    part_type_speed(global.part_type_bubblePop, 9, 11, -0.4, 0)
    part_type_orientation(global.part_type_bubblePop, 0, 360, 0, 0, 0)
    part_type_direction(global.part_type_bubblePop, 0, 360, 0, 0)
    part_type_size(global.part_type_bubblePop, 0.1, 0.2, -0.008, 0)
    part_type_gravity(global.part_type_bubblePop, 0, 270)
    global.part_type_deathBounce = part_type_create()
    part_type_color1(global.part_type_deathBounce, merge_color(col_snail_death, c_white, 0.5))
    part_type_life(global.part_type_deathBounce, 30, 30)
    part_type_sprite(global.part_type_deathBounce, 2, 0, 0, 1)
    part_type_alpha3(global.part_type_deathBounce, 1, 0.25, 0)
    global.part_typle_falling_brick = part_type_create()
    part_type_color1(global.part_typle_falling_brick, col_wall_outline)
    part_type_life(global.part_typle_falling_brick, 40, 40)
    part_type_sprite(global.part_typle_falling_brick, 11, 0, 0, 1)
    part_type_direction(global.part_typle_falling_brick, 260, 280, 0, 0)
    part_type_speed(global.part_typle_falling_brick, 1, 10, 0, 0)
    part_type_size(global.part_typle_falling_brick, 0.3, 0.5, -0.01, 0)
    part_type_alpha3(global.part_typle_falling_brick, 1, 0.7, 0)
    global.part_type_shot_hit = part_type_create()
    part_type_color1(global.part_type_shot_hit, merge_color(col_snail, c_white, 0.5))
    part_type_sprite(global.part_type_shot_hit, 211, 1, 1, 0)
    part_type_life(global.part_type_shot_hit, 20, 25)
    part_type_orientation(global.part_type_shot_hit, 0, 360, 0, 0, 0)
    global.part_type_human_blood = part_type_create()
    part_type_color2(global.part_type_human_blood, col_player_trail, col_snail)
    part_type_life(global.part_type_human_blood, 10, 40)
    part_type_sprite(global.part_type_human_blood, 11, 0, 0, 1)
    part_type_direction(global.part_type_human_blood, 0, 360, 0, 0)
    part_type_speed(global.part_type_human_blood, 1, 4, 0, 0)
    part_type_gravity(global.part_type_human_blood, 0.3, 270)
    part_type_size(global.part_type_human_blood, 0.05, 0.15, -0.005, 0)
    global.part_type_fire = part_type_create()
    part_type_color_mix(global.part_type_fire, col_ai, merge_color(col_ai2, c_white, 0.2))
    part_type_life(global.part_type_fire, 200, 300)
    part_type_alpha3(global.part_type_fire, 1, 0.25, 0)
    part_type_sprite(global.part_type_fire, 10, 0, 0, 1)
    part_type_speed(global.part_type_fire, 0.1, 0.5, -0.01, 0)
    part_type_orientation(global.part_type_fire, 0, 360, 0, 0, 0)
    part_type_direction(global.part_type_fire, 0, 360, 0, 0)
    part_type_size(global.part_type_fire, 0.05, 0.2, 0, 0)
    part_type_gravity(global.part_type_fire, 0.025, 90)
    global.part_type_horizon_storm = part_type_create()
    part_type_color_mix(global.part_type_horizon_storm, col_ai, 0)
    part_type_life(global.part_type_horizon_storm, 40, 400)
    part_type_alpha3(global.part_type_horizon_storm, 1, 0.25, 0)
    part_type_sprite(global.part_type_horizon_storm, 10, 0, 0, 1)
    part_type_speed(global.part_type_horizon_storm, 30, 30, -0.1, 0)
    part_type_direction(global.part_type_horizon_storm, 177, 187, 0, 0)
    part_type_size(global.part_type_horizon_storm, 0.05, 0.2, 0, 0)
    part_type_scale(global.part_type_horizon_storm, 4, 1)
    global.part_type_aiSparks = part_type_create()
    part_type_color_mix(global.part_type_aiSparks, col_ai, merge_color(col_ai2, c_white, 0.4))
    part_type_life(global.part_type_aiSparks, 40, 250)
    part_type_alpha3(global.part_type_aiSparks, 1, 0.25, 0)
    part_type_sprite(global.part_type_aiSparks, 10, 0, 0, 1)
    part_type_speed(global.part_type_aiSparks, 0, 4.5, -0.1, 0)
    part_type_orientation(global.part_type_aiSparks, 0, 360, 0, 0, 0)
    part_type_direction(global.part_type_aiSparks, 0, 360, 0, 0)
    part_type_size(global.part_type_aiSparks, 0.02, 0.15, 0, 0)
    part_type_gravity(global.part_type_aiSparks, 0.2, 270)
    global.part_type_puzzleActivation = part_type_create()
    part_type_color2(global.part_type_puzzleActivation, merge_color(col_snail, c_white, 0.75), col_snail)
    part_type_life(global.part_type_puzzleActivation, 200, 200)
    part_type_sprite(global.part_type_puzzleActivation, 213, 0, 0, 1)
    part_type_orientation(global.part_type_puzzleActivation, 0, 0, 0, 0, 0)
    part_type_direction(global.part_type_puzzleActivation, 80, 100, 0, 0)
    sazi = 0.7
    part_type_size(global.part_type_puzzleActivation, (sazi * 0.8), sazi, ((-sazi) / 200), 0)
    part_type_orientation(global.part_type_puzzleActivation, 0, 360, 0, 0, 0)
    part_type_speed(global.part_type_puzzleActivation, 0, 2.5, 0, 0)
    part_type_gravity(global.part_type_puzzleActivation, 0.005, 90)
    global.part_type_showPrediction = part_type_create()
    part_type_color3(global.part_type_showPrediction, 16777215, 16777215, 16777215)
    part_type_life(global.part_type_showPrediction, 2, 2)
    part_type_sprite(global.part_type_showPrediction, 10, 0, 0, 1)
    part_type_size(global.part_type_showPrediction, 0.1, 0.1, 0, 0)
    global.part_type_glowSparksExplorationPoint = part_type_create()
    part_type_color1(global.part_type_glowSparksExplorationPoint, merge_color(col_exploration_point, c_white, 0.4))
    part_type_life(global.part_type_glowSparksExplorationPoint, 120, 120)
    part_type_size(global.part_type_glowSparksExplorationPoint, 0.4, 0.4, -0.0033333333333333335, 0)
    part_type_sprite(global.part_type_glowSparksExplorationPoint, 199, 0, 0, 1)
    part_type_speed(global.part_type_glowSparksExplorationPoint, 1, 1, 0, 0)
    part_type_orientation(global.part_type_glowSparksExplorationPoint, 0, 360, 0, 0, 0)
    part_type_direction(global.part_type_glowSparksExplorationPoint, 0, 360, 5, 0)
    global.part_type_underwBubbles = part_type_create()
    part_type_color1(global.part_type_underwBubbles, col_bubbles)
    part_type_alpha3(global.part_type_underwBubbles, 1, 1, 0)
    part_type_direction(global.part_type_underwBubbles, 80, 100, 0, 10)
    part_type_speed(global.part_type_underwBubbles, 1, 3, 0.05, 0)
    part_type_life(global.part_type_underwBubbles, 60, 120)
    part_type_sprite(global.part_type_underwBubbles, 202, 0, 0, 0)
    part_type_size(global.part_type_underwBubbles, 0.1, 0.5, 0, 0)
    global.part_type_zeroOne = part_type_create()
    part_type_color_mix(global.part_type_zeroOne, col_ai, col_ai2)
    part_type_life(global.part_type_zeroOne, 15, 60)
    part_type_sprite(global.part_type_zeroOne, 46, 0, 0, 1)
    part_type_size(global.part_type_zeroOne, 1, 3, 0, 0)
    part_type_speed(global.part_type_zeroOne, 1, 2, 0, 0)
    part_type_direction(global.part_type_zeroOne, 0, 360, 0, 0)
    global.part_type_tentacleKill = part_type_create()
    part_type_color_mix(global.part_type_tentacleKill, col_traps, merge_color(col_traps, c_white, 0.2))
    part_type_life(global.part_type_tentacleKill, 80, 150)
    part_type_alpha3(global.part_type_tentacleKill, 1, 0.25, 0)
    part_type_sprite(global.part_type_tentacleKill, 10, 0, 0, 1)
    part_type_speed(global.part_type_tentacleKill, 3, 7, -0.07, 0)
    part_type_orientation(global.part_type_tentacleKill, 0, 360, 0, 0, 0)
    part_type_direction(global.part_type_tentacleKill, 0, 360, 0, 0)
    part_type_size(global.part_type_tentacleKill, 0.04, 0.1, 0, 0)
    part_type_gravity(global.part_type_tentacleKill, 0.03, 270)
    global.part_type_ceilingTouch = part_type_create()
    part_type_color_mix(global.part_type_ceilingTouch, col_wall_outline, col_wall_outline2)
    part_type_life(global.part_type_ceilingTouch, 10, 30)
    part_type_alpha3(global.part_type_ceilingTouch, 1, 0.75, 0)
    part_type_sprite(global.part_type_ceilingTouch, 10, 0, 0, 0)
    part_type_speed(global.part_type_ceilingTouch, 0, 2.5, -0.1, 0)
    part_type_orientation(global.part_type_ceilingTouch, 0, 360, 0, 0, 0)
    part_type_direction(global.part_type_ceilingTouch, 180, 360, 0, 0)
    part_type_size(global.part_type_ceilingTouch, 0.01, 0.04, 0, 0)
    part_type_gravity(global.part_type_ceilingTouch, 0.2, 270)
}
time = 0
global.levelstyler_colors_need_to_be_reloaded = 0
