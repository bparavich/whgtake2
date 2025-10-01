extends Control

@export var level: PackedScene

func _on_mouse_entered() -> void:
	var stylebox: StyleBoxFlat = $Panel.get_theme_stylebox("panel")
	stylebox.border_color = Color(1.0, 0.0, 0.0, 1.0)
	$Panel/Label.add_theme_color_override("font_color", Color(1.0, 0.0, 0.0, 1.0))


func _on_mouse_exited() -> void:
	var stylebox: StyleBoxFlat = $Panel.get_theme_stylebox("panel")
	stylebox.border_color = Color(0.38, 0.38, 0.4, 1.0)
	$Panel/Label.add_theme_color_override("font_color", Color(0.0, 0.0, 0.0, 1.0))


func _on_panel_gui_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("click"):
		get_tree().change_scene_to_packed(level)
