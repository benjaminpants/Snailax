if (argument0 == obj_evil_snail)
{
	return [30,58]
}
if (argument0 == obj_spike_permanent or argument0 == obj_ice_spike)
{
	return [30,60]
}
if (argument0 == obj_playerspawn or argument0 == obj_squasher or argument0 == obj_bomb_spawner or argument0 == obj_gun or argument0 == obj_enemy or argument0 == obj_bubble or argument0 == obj_drone_spawner or argument0 == obj_sh_enemy_spawnpoint_normy or argument0 == obj_exploration_point or argument0 == obj_protector or argument0 == obj_uplifter)
{
	return [30,30]
}
if (argument0 == obj_speedbooster)
{
	return [35,35]
}
if (argument0 == obj_sh_gun or argument0 == obj_sh_gun2 or argument0 == obj_sh_gun3 or argument0 == obj_sh_gun4)
{
	return [30,60]
}
return [0,0]