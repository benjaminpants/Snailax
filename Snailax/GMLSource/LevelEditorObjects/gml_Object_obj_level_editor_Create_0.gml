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
cur_selected_slot = 0
room_mult_x = 1
room_mult_y = 1
starting_play_mode = false

cam_x = 0
cam_y = 0

placing_rotation = 0



current_level_name = "my_epic_level"

current_song = 0

current_theme = 0


//0 = Jump and Die
//1 = Simulated Life
//2 = Simulated Life(Underwater)
//3 = Quietly Searching(Currently Unavailable)
//4 = Make It Pain
//5 = Admitting Defeat
//6 = Shelly Fire
//7 = Demolition Warning
//8 = Disco Of Doom
//9 = Chill Zone
//10 = Mr. Dance
//11 = Underwater
//12 = Mama Squid
//13 = Death By Nanobots
//14 = Helpy Loves You
//15 = Winter Mode
//16 = Artifical Joy
//17 = Tension
//18 = Final Encounter
//19 = Reality Diving
//20 = Brain Ambience
//21 = Shelly Fire(Underwater)
all_music_objects = [obj_music_main, obj_music_LightOcean, obj_music_LightOceanUnderw, obj_music_main, obj_music_crazy, obj_music_NoHope, obj_music_shooter, obj_music_BlockyBoss, obj_music_disco, obj_music_disco_silent, obj_music_MrDance, obj_music_underwater, obj_music_MamaSquid, obj_music_bubble_gum,obj_music_helpy, obj_music_winter, obj_music_ArtificialFun, obj_music_tension, obj_music_final_boss, obj_music_WaitingForHorizon, obj_music_InBrainSoundscape, obj_music_underwater_shooter]

all_styler_objects = [obj_levelstyler, obj_levelstyler_bubblegum, obj_levelstyler_disco, obj_levelstyler_underwater, obj_levelstyler_brain, obj_levelstyler_winter, obj_levelstyler_glitchy]


all_objects = [obj_wall,obj_wallB,obj_spike_permanent,obj_playerspawn, obj_conveyor_belt,obj_bomb_spawner,obj_sh_gun, obj_sh_gun2, obj_sh_gun3, obj_destructable_wall, obj_explosive_wall, obj_gun, obj_enemy, obj_bubble, obj_difficulty_shower, obj_drone_spawner, obj_sh_enemy_spawnpoint_normy, obj_exploration_point, obj_wall_walkthrough, obj_protector,obj_uplifter, obj_speedbooster, obj_ice_spike, obj_evil_snail, obj_squasher, obj_underwater_current, obj_fish, obj_jellyfish, obj_drone_piranha_spawner, obj_wall_brain]

all_objects_name = ["Wall", "Wall(alt)", "Spike", "Player Spawnpoint", "Conveyer Belt", "Bomb Spawner", "Upwards Facing Gun", "Side Facing Gun", "Downwards Facing Gun", "Destructable Tile", "Explosive Tile", "Turret", "Gift Box", "Bubble", "Difficulty Preview", "Drone Spawner", "Bouncy Cube", "Discovery Point", "Walkthroughable Wall", "Protectors", "Spirit Lifter", "Spirit Booster", "Ice Spike", "Robo-Shelly", "Squasher", "Current" , "Fish", "Jellyfish", "Piranha", "Cricut Wall"]

all_objects_layers = ["Walls","Walls","Spikes","Player","Goal","MiniGames","Player","Player","Player", "MiniGames", "MiniGames", "Spikes", "Traps", "MiniGames", "Walls", "Traps", "Spikes", "Goal", "Walls" , "Traps", "MiniGames", "MiniGames" , "Traps", "Traps", "Spikes", "BackDecoration", "Traps", "Traps", "Traps", "Walls"] //have no idea why conveyer belts are on the goal layer but oh well

//DDR
//darkness
current_gimmicks = [false,false]
current_gimmicks_names = ["Arrows", "Darkness"]
max_gimmicks = array_length_1d(current_gimmicks)

global.current_character = 0 //disable custom characters

if (!variable_global_exists("current_palette"))
{

	global.current_palette = [obj_wall,obj_wallB,obj_spike_permanent,obj_playerspawn, obj_conveyor_belt, obj_bomb_spawner, obj_sh_gun, obj_destructable_wall, obj_gun] //why reference the objects instead of the index in all_objects? Incase I move things around, dont wanna mess things up

	global.current_palette_layers = ["Walls","Walls","Spikes","Player","Goal","MiniGames","Player","MiniGames","Spikes"]

}

being_destroyed = false


if (!variable_global_exists("last_loaded_c_level"))
{
	global.last_loaded_c_level = ""
}

//valid modes are:
//main
//placing
//palette_select
//palette_change
cur_mode = "placing"


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