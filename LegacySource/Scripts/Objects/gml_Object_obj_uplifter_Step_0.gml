if (instance_exists(obj_level_editor))
{
	image_blend = obj_levelstyler.col_wall_outline
    visible = true
}
else
{
	if (obj_player.dead != -1)
	{
		cooldown = 0
		return false;
	}
	cooldown--
	if (cooldown <= 0 && ((global.save_anger_game_level >= unlock_at_level) or room == level_basic_copy_me))
	{
		if (visible == false)
			image_blend = obj_levelstyler.col_wall_outline
		visible = true
	}
	else
		visible = false
	//image_xscale = sign((x - obj_player.x))
	//why is this code even IN this object??
}

