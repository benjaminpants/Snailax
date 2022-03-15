var lay_id, a, i;

x = (round((mouse_x / 60)) * 60)
y = (round((mouse_y / 60)) * 60)

//offsets because not every object has the same alignment point as the wall sprite
if (placing == obj_rusty_spike)
{
	offset_x = 30
	offset_y = 60
}
else if (placing == obj_playerspawn)
{
	offset_x = 30
	offset_y = 30
}
else
{
	offset_x = 0
	offset_y = 0
}

if (mouse_check_button(mb_left) and (x != prev_x or y != prev_y))
{
	prev_x = x
	prev_y = y
	instance_create_layer(x + offset_x, y + offset_y, placing_layer, placing)
	//destroy the current level styler
	instance_destroy(obj_levelstyler)
	//forcefully clear all the walllines
	lay_id = layer_get_id("WallLines")
	a = layer_get_all_elements(lay_id)
	for (i = 0; i < array_length_1d(a); i++)
		layer_sprite_destroy(a[i])
	//recreate the level styler
	instance_create_layer(0, 0, "Player", obj_levelstyler)
	audio_play_sound(sou_increaseHandicapA,0,false)
}

if mouse_check_button(mb_right)
{
	
	var inst = instance_place(x, y, placing) //only specifically checking for what your placing because i was too lazy to search up how to check for any object
	
	if (inst != noone)
	{
		instance_destroy(inst)
		audio_play_sound(sou_respawn,0,false)
	}
	
	//destroy the current level styler
    instance_destroy(obj_levelstyler)
	//forcefully clear all the walllines
    lay_id = layer_get_id("WallLines")
    a = layer_get_all_elements(lay_id)
    for (i = 0; i < array_length_1d(a); i++)
        layer_sprite_destroy(a[i])
	//recreate the level styler
    instance_create_layer(0, 0, "Player", obj_levelstyler)
}


if (keyboard_check_pressed(ord("1")))
{
    placing = obj_wall
    placing_layer = "Walls"
}

if (keyboard_check_pressed(ord("2")))
{
    placing = obj_wallB
    placing_layer = "Walls"
}

if (keyboard_check_pressed(ord("3")))
{
    placing = obj_rusty_spike
    placing_layer = "Spikes"
}

if (keyboard_check_pressed(ord("4")))
{
    placing = obj_playerspawn
    placing_layer = "Player"
}


if (keyboard_check_pressed(vk_f1))
{
	instance_create_layer(obj_playerspawn.x, obj_playerspawn.y, "Player", obj_player)
	instance_create_layer(obj_playerspawn.x, obj_playerspawn.y, "Player", asset_get_index("obj_ai_level_0" + string(get_integer("Choose squid level 0-5.",1))))
	instance_destroy(obj_playerspawn)
    instance_destroy()
}