extends Node2D

@export var level: int = 0
@onready var traps := get_tree().get_nodes_in_group("trap")
@onready var coins := get_tree().get_nodes_in_group("coin")
@onready var wins := get_tree().get_nodes_in_group("win")
@export var score_required: int
@onready var win_area: Area2D = $WinArea
@onready var player: Player = $Player
@export var next_level: PackedScene = null
@export var has_checkpoint: bool

var coins_collected: Array[String] = []
var score: int = 0

func _ready() -> void:
	#Updates hud with current level
	$HUD.update_level(level)
	#Hides the score required label if no coins present on level
	if score_required == 0:
		$HUD/UI/Score.visible = false
	else:
		$HUD.update_score(score, score_required)
		$HUD/UI/Score.visible = true
	
	#Updated as part of a later if statement to assure a player doesnt get hit and die 'twice' while still alive
	StatManager.is_reloading_scene = false
	
	#If the level contains a checkpoint the score is appropriately updated instead of being reset
	if has_checkpoint:
		StatManager.has_checkpoint = true
		score = StatManager.checkpoint_score
		$HUD.update_score(score, score_required)
		if StatManager.died_this_level: #This makes sure to set the player position to apppropriate checkpoint location
			$Player.set_player_postion(has_checkpoint)
		
	#If this level is standard 1 start/exit level on any subsequent death the start area glows at the beginning of the next attempt
	if has_checkpoint == false and StatManager.died_this_level == true:
		$Background.start_glow()
	
	#Here we have arrays stored with nodes in a group and we run through the array connecting each signal avilable to the functions located in this script
	for area in wins:
		area.win.connect(_on_player_win)	
	
	for coin in coins:
		coin.coin_collected.connect(_on_coin_collected)
		
	for trap in traps:
		trap.died.connect(_on_player_died)
	
func _process(_delta: float) -> void:
	#Checks to see if escape was pressed to quit game
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
func _on_player_died():
	#Adds to the fails counter and also saves that a death has occured
	$HUD.update_deaths()
	StatManager.died_this_level = true
	
	#if there arent any checkpoints then the score is reset to 0
	if not has_checkpoint:
		score = 0
	
	#For levels with individual trap animations this goes through to stop them all
	for trap in traps:
		trap.trap_animation.pause()
	
	#Slight pause for vibe
	await get_tree().create_timer(1.0).timeout
	
	#prevents a double trigger on levels with deathballs close together and hitting player multiple times
	if not StatManager.is_reloading_scene:
		StatManager.deaths += 1
		get_tree().call_deferred("reload_current_scene")
		StatManager.is_reloading_scene = true
	elif StatManager.is_reloading_scene:
		return
	
func _on_player_win(number, location):
	#Makes sure that the correct amount of coins has been collected
	if score == score_required:
		StatManager.has_checkpoint = false #Resets this to false for the next level to change
		StatManager.died_this_level = false #Resets this to false to prepare for the next leves
		score = 0 #Reset for next level
		StatManager.coins_collected = [] #Clears the array remembering what coins have been obtained this level
		
		$Background.win_glow(number) #Make the correct win zone play its glowing animation

		await get_tree().create_timer(0.3).timeout
		$Player.fade_animation()
		await get_tree().create_timer(1.5).timeout
		StatManager.check_number = 0 #Resets to 0 to prepare for next level. The timers cause pauses in animations for final effects
		get_tree().change_scene_to_packed(next_level)
		
	elif score < score_required:
		if has_checkpoint: #Plays the animation at the apporpriate checkpoint and updates the coins collected array and saves the score and location incase player dies and resets
			$Background.win_glow(number)
			StatManager.check_number = number
			StatManager.coins_collected.append_array(coins_collected)
			StatManager.checkpoint_score = score
			StatManager.player_position = location

func _on_coin_collected(coin_name):
	#Updates score and coin collected array, also displays proper score
	score += 1
	coins_collected.append(coin_name)
	$HUD.update_score(score, score_required)
