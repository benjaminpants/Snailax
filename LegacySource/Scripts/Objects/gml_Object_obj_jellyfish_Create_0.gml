image_speed = 0
alarm = 1
ready_to_attack = 1
attack_x = 0
attack_y = 0
attack_speed = 0
if (global.save_difficulty == 0)
    attack_range = 225
if (global.save_difficulty == 1)
    attack_range = 225
if (global.save_difficulty == 2)
    attack_range = 225
if (global.save_difficulty == 3)
    attack_range = 225
scr_autowhobble_ini()
time = random(10000)
warncol = 0
warncol_target = 0
size = 1
size_target = 1
tent1_angle = 0
tent2_angle = 0
tent3_angle = 0
warncol_col = merge_color(obj_levelstyler.col_traps, c_white, 0.5)
col = obj_levelstyler.col_traps
prediction_flash = 0.5