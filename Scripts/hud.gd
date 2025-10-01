extends CanvasLayer

func _ready() -> void:
	#Hides and showes the 'un' before mute when muted is true or false respectively
	if StatManager.muted == true:
		$UI/UN.visible = true
	update_deaths()
	
func _process(_delta: float) -> void:
	#constantly checks for if p was pressed to active the pause function
	if Input.is_action_just_pressed("pause"):
		_on_pause_menu_pressed()

#These 3 functions exist to just updated labels with correct info
func update_level(level):
	$UI/Level.text ="LEVEL: " + str(level)
	
func update_score(coins, coins_needed):
	$UI/Score.text = "COINS: " + str(coins) + "/" + str(coins_needed)
	
func update_deaths():
	$UI/Deaths.text = "FAILS: " + str(StatManager.deaths)


func _on_pause_menu_pressed() -> void:
	#Pauses the game if it isnt paused and makes the pause menu visible
	if get_tree().paused:
		$PauseMenu.visible = false
		get_tree().paused = false
	elif get_tree().paused == false:
		get_tree().paused = true
		$PauseMenu.visible = true

#simple enough, if game is muted, unmute and if unmuted, mute. Also hides and unhided the 'un' in mute
func _on_mute_pressed() -> void:
	if StatManager.muted == false:
		$UI/UN.visible = true
		StatManager.muted = true
	elif StatManager.muted == true:
		$UI/UN.visible = false
		StatManager.muted = false
	
	#These next 2 just take the player to the mentioned screen, resetting global stats and unpausing the game
func _on_main_menu_pressed():
	reset()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	
func _on_level_select_pressed():
	reset()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/level_select.tscn")
	
	
#Changes the color to yellow when hovered and back to white when done
func change_un_color_yellow():
	$UI/UN.add_theme_color_override("font_color", Color(0.871, 0.867, 0.0, 1.0))
	
func change_un_color_white():
	$UI/UN.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0, 1.0))
	
func reset():
	#Resets all global variables for a fresh gamestate
	StatManager.deaths = 0
	StatManager.died_this_level = false
	StatManager.player_position = Vector2.ZERO
	StatManager.coins_collected = []
	StatManager.checkpoint_score = 0
	StatManager.has_checkpoint = false
	StatManager.check_number = 0
	StatManager.is_reloading_scene = false
	StatManager.muted = false
