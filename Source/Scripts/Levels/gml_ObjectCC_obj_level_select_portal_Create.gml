level = asset_get_index("level_basic_copy_me")
beaten_on_diff = 0
beaten_on_diff_underw = 0
type = 1
deaths = 0
playtime = 0
autodiff_difficulty = 0
autodiff_playtime = 0
sprite_index = 344
name = "Level Editor"
more_to_explore = false
is_boss = false
exploration_points_collected = []
locked_level = false
if (global.save_pump_is_inverted)
{
	name = "Nice Try, but no."
	locked_level = true
}