scr_colgrid_point_move_contact = function(argument0, argument1) //gml_Script_scr_colgrid_point_move_contact
{
    movecontact_dir = argument0
    movecontact_maxdist = argument1
    movecontact_xspeed = lengthdir_x(1, movecontact_dir)
    movecontact_yspeed = lengthdir_y(1, movecontact_dir)
    movecontact_cos_dir = abs(cos(((movecontact_dir / 180) * pi)))
    movecontact_sin_dir = abs(sin(((movecontact_dir / 180) * pi)))
    movecontact_iteration = 0
    while (movecontact_iteration <= 100)
    {
        if (movecontact_xspeed > 0)
            movecontact_xmissing = ((ceil((x / 60)) * 60) - x)
        else
            movecontact_xmissing = (x - (floor((x / 60)) * 60))
        if (movecontact_yspeed > 0)
            movecontact_ymissing = ((ceil((y / 60)) * 60) - y)
        else
            movecontact_ymissing = (y - (floor((y / 60)) * 60))
        if (movecontact_xspeed == 0)
            movecontact_xmissing_time = 1000000
        else
            movecontact_xmissing_time = (movecontact_xmissing / abs(movecontact_xspeed))
        if (movecontact_yspeed == 0)
            movecontact_ymissing_time = 1000000
        else
            movecontact_ymissing_time = (movecontact_ymissing / abs(movecontact_yspeed))
        if (movecontact_xmissing_time < movecontact_ymissing_time && movecontact_xmissing != 0)
        {
            llen = (movecontact_xmissing / movecontact_cos_dir)
            if (llen >= movecontact_maxdist)
                llen = movecontact_maxdist
            x += (lengthdir_x(llen, movecontact_dir) + (0.0005 * sign(movecontact_xspeed)))
            y += lengthdir_y(llen, movecontact_dir)
            movecontact_maxdist -= llen
        }
        else if (movecontact_ymissing != 0)
        {
            llen = (movecontact_ymissing / movecontact_sin_dir)
            if (llen >= movecontact_maxdist)
                llen = movecontact_maxdist
            x += lengthdir_x(llen, movecontact_dir)
            y += (lengthdir_y(llen, movecontact_dir) + (0.0005 * sign(movecontact_yspeed)))
            movecontact_maxdist -= llen
        }
        else
        {
            llen = 0.1
            if (llen >= movecontact_maxdist)
                llen = movecontact_maxdist
            x += lengthdir_x(llen, movecontact_dir)
            y += lengthdir_y(llen, movecontact_dir)
            movecontact_maxdist -= llen
        }
        if (movecontact_maxdist <= 0)
            break
        else if (x <= -60 || y <= -60 || x >= (room_width + 60) || y >= (room_height + 60))
            break
        else if global.collision_array[clamp((floor((x / 60)) + 1),0,array_height_2d(global.collision_array) - 1)][clamp((floor((y / 60)) + 1),0,array_height_2d(global.collision_array) - 1)] //I DONT KNOW WHY THIS WAS BROKEN AS I NEVER TOUCHED THIS, BLAME JONAS.
        {
            x -= lengthdir_x(0.001, movecontact_dir)
            y -= lengthdir_y(0.001, movecontact_dir)
            break
        }
        else
        {
            movecontact_iteration++
            continue
        }
    }
    return;
}

