placing = obj_wall
placing_layer = "Walls"
image_speed = 0.25
offset_x = 0
offset_y = 0
grid_x = 60
grid_y = 60
prev_x = 0
prev_y = 0
level_saved = false
cur_selected_item = 0

all_objects = [obj_wall,obj_wallB,obj_spike_permanent,obj_playerspawn, obj_conveyor_belt]

current_palette = [obj_wall,obj_wallB,obj_spike_permanent,obj_playerspawn, obj_conveyor_belt] //why reference the objects instead of the index in all_objects? Incase I move things around, dont wanna mess things up

//valid modes are:
//main
//place
//palette_select
//palette_change
cur_mode = "palette_select"


//squid games!!!
squid_ground_spike_probability = 0
squid_wall_spike_probability = 0
squid_ceiling_spike_probability = 0
squid_air_cat_probability = 0
squid_badball_probability = 0
squid_combletely_disabled = 0
squid_ice_spike_down_probability = 0
squid_fireworks_probability = 0
squid_conveyor_belt_change_probability = 0.01
squid_laser_probability = 0