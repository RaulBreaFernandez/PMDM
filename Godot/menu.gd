extends Control



var level = "res://world/world.tscn"

func _on_play_button_click_end():
	get_tree().quit()
	
func _on_quit_button_click_end():
	var _level = get_tree().change_scene_to_file(level)
