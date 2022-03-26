scr_move_like_a_snail_ini = function() //gml_Script_scr_move_like_a_snail_ini
{
    groundedremember = -1
    jumpremember = -1
    airjumps = 0
    underwater = 0
    timesincelastjump = 0
    if instance_exists(obj_levelstyler_underwater)
        underwater = 1
    inbubble = 0
	move_multiplier = 1 //i hate undertale mod tool
	weight_multiplier = 1
	jump_multiplier = 1
	conveyor_multiplier = 1
	jumpc_multiplier = 1
	hover_time = 120
    return;
}

