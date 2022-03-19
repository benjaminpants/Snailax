if (argument0 == obj_spike_permanent)
{
	return [30,60]
}
if (argument0 == obj_playerspawn or argument0 == obj_bomb_spawner or argument0 == obj_gun or argument0 == obj_enemy or argument0 == obj_bubble)
{
	return [30,30]
}
if (argument0 == obj_sh_gun or argument0 == obj_sh_gun2 or argument0 == obj_sh_gun3 or argument0 == obj_sh_gun4)
{
	return [30,60]
}
return [0,0]