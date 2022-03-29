if (!instance_exists(obj_ai_representation))
{
    if (!instance_exists(obj_no_squid_in_this_level))
        instance_create_layer((room_width / 2), (room_height / 2), "AI_Representation", obj_ai_representation)
}
if (!variable_global_exists("current_character"))
{
	global.current_character = 0
	
	//default character is shelly!!
}
scr_autowhobble_ini()
audio_falloff_set_model(5)
dragging_power_connection = -1
gamepad_rumble = 0
gun_equipped = 0
gun_cooldown = 0
audio_listener_orientation(0, 0, 1, 0, -1, 0)
snail_voice_sound = -1
reading_file = -1
lookdir = 1
lookdir_start = 1
lookdir_smooth = lookdir
scr_move_like_a_snail_ini()
victory = -1
dead = -1
particletraveldist = 0
xlast = x
ylast = y
if (!instance_exists(obj_persistent))
    instance_create_layer(0, 0, "Walls", obj_persistent)
if (!instance_exists(obj_camera_control))
    instance_create_layer(0, 0, layer, obj_camera_control)
if (!instance_exists(obj_levelstyler))
    instance_create_layer(0, 0, layer, obj_levelstyler)
if (!instance_exists(obj_wall_shader))
    instance_create_layer(0, 0, "Walls", obj_wall_shader)
if instance_exists(obj_dark_level)
{
    if (!instance_exists(obj_darkFollowFlare))
        instance_create_layer(0, 0, "AI_Representation", obj_darkFollowFlare)
}
nomovement_timer = 0
eye1 = instance_create_layer(x, y, "Player_Eyes", obj_snaili_eye)
eye1.eye = 1
eye2 = instance_create_layer(x, y, "Player_Eyes", obj_snaili_eye)
eye2.eye = 2
house_height = 1
house_width = 1
house_tilt = 0
lockmovement = 40
wind_sound_fall_volume = 0
wind_sound_fall = audio_play_sound(sou_wind_high, 1, true)
audio_sound_gain_fx(wind_sound_fall, 0, 0)
wind_sound_slither_volume = 0
wind_sound_slither = audio_play_sound(sou_slither_no_paper, 1, true)
audio_sound_gain_fx(wind_sound_slither, 0, 0)
alarm = 1
col_snail_outline = 0
col_snail_body = 0
col_snail_shell = 0
col_snail_eye = 0
if instance_exists(obj_levelstyler)
{
    if variable_instance_exists(obj_levelstyler.id, "col_snail_body")
        event_user(0)
}
time = 0
active_time = 0
inbubble_flash = 0
hspeed_last = 0
in_water_current = 0
bubbleindicator = 0
allow_restarts = 1
bonus_speed_by_conveyor = 0
extra_speed_mode = 0
if (room == level_select || room == story_library)
    extra_speed_mode = 1
started_playing = 0
scr_spawn_correct_hat()
with (obj_hat_parent)
{
    if (dead == 0)
        y = (obj_player.y - 30)
}
holding_jump_without_moving_timer = 0
glitch_mode_and_dir = -1
global.player_using_glitch_timer = 0
speedboosted = 0
speedboosted_grace_period = -1
alarm[1] = 300
