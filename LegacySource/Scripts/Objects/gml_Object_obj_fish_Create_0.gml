image_speed = 0
time = random(1000)
fishwhiggletime = 0
fishwiggle = 0
wingwiggle = 0
alarm = 1
basic_speed = 2
wiggle_strength = 10
if (global.save_difficulty == 0)
    speedup_speed = 8
if (global.save_difficulty == 1)
    speedup_speed = 10
if (global.save_difficulty == 2)
    speedup_speed = 12
if (global.save_difficulty == 3)
    speedup_speed = 14
base_speed = basic_speed
base_dir = image_angle
base_x = x
base_y = y
speedup_timer = -1
scale = 1
warncol = 0
warncol_target = 0
warncol_col = 0
col = 0
image_blend = c_black
