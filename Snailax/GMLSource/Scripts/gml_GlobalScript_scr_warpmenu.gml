with (obj_persistent)
{
    global.go_to_room_after_menu = snailax_editor_room
    scr_save_settings()
    inMainMenu = 0
    room_goto(roomBeforeMenu)
    room_persistent = false
    roomBeforeMenu = -1
    with (obj_aivl_parent)
        instance_destroy()
    with (obj_music_parent)
        instance_destroy()
    audio_stop_all()
    sound = audio_play_sound(sou_game_start, 1, false)
	audio_sound_gain_fx(sound, 1, 0)
}