if (room != level_basic_copy_me)
{
if (global.save_difficulty == 0)
    motion_add(image_angle, 2)
if (global.save_difficulty == 1)
    motion_add(image_angle, 3)
if (global.save_difficulty == 2)
    motion_add(image_angle, 4)
if (global.save_difficulty == 3)
    motion_add(image_angle, 5)
}
alarm = 1
scr_autowhobble_ini()
