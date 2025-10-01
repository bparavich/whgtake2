extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _on_play_game_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")

func _on_level_select_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_select.tscn")
