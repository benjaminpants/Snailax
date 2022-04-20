if (argument0 == spr_power_antenna or argument0 == spr_power_antenna_big_range or argument0 == spr_power_generator or argument0 == spr_power_generator_far or argument0 == spr_floaty_antenna)
{
	return [0,argument0,0.5]
}

if (argument0 == spr_snail_house_gun or argument0 == spr_snail_house_gun2 or argument0 == spr_snail_house_gun3 or argument0 == spr_snail_house_gun4)
{
	return [2,argument0,1]
}

if (argument0 == spr_difficulty_display_old or argument0 == spr_underwater_current)
{
	return [0,argument0,0.25]
}

if (argument0 == spr_shooter_enemy_basic)
{
	return [0, argument0, 0.5]
}


return [0,argument0,1]