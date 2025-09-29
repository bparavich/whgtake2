extends CanvasLayer

func _ready() -> void:
	if StatManager.muted == true:
		$UI/UN.visible = true
	update_deaths()
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		_on_pause_menu_pressed()

func update_level(level):
	$UI/Level.text ="LEVEL: " + str(level)
	
func update_score(coins, coins_needed):
	$UI/Score.text = "COINS: " + str(coins) + "/" + str(coins_needed)
	
func update_deaths():
	$UI/Deaths.text = "FAILS: " + str(StatManager.deaths)


func _on_pause_menu_pressed() -> void:
	if get_tree().paused:
		$PauseMenu.visible = false
		get_tree().paused = false
	elif get_tree().paused == false:
		get_tree().paused = true
		$PauseMenu.visible = true

func _on_mute_pressed() -> void:
	if StatManager.muted == false:
		$UI/UN.visible = true
		StatManager.muted = true
	elif StatManager.muted == true:
		$UI/UN.visible = false
		StatManager.muted = false
		
func _on_main_menu_pressed():
	StatManager.deaths = 0
	StatManager.died_this_level = false
	StatManager.player_position = Vector2.ZERO
	StatManager.coins_collected = []
	StatManager.checkpoint_score = 0
	StatManager.has_checkpoint = false
	StatManager.check_number = 0
	StatManager.is_reloading_scene = false
	StatManager.muted = false
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
func _on_level_select_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/level_select.tscn")
	
func change_un_color_yellow():
	$UI/UN.add_theme_color_override("font_color", Color(0.871, 0.867, 0.0, 1.0))
	
func change_un_color_white():
	$UI/UN.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0, 1.0))
