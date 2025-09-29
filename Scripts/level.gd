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
var _1_was_last: bool = false
var _2_was_last: bool = false
var _3_was_last: bool = false
var _4_was_last: bool = false

func _ready() -> void:	
	$HUD.update_score(score, score_required)
	StatManager.is_reloading_scene = false
	
	if has_checkpoint:
		StatManager.has_checkpoint = true
		score = StatManager.checkpoint_score
		$HUD.update_score(score, score_required)
		
	if has_checkpoint == false and StatManager.died_this_level == true:
		$Background.start_glow()
		
	if StatManager.died_this_level == true:
		$Player.set_player_postion(has_checkpoint)
		
	for area in wins:
		area.win.connect(_on_player_win)	
	
	for coin in coins:
		coin.coin_collected.connect(_on_coin_collected)
		
	for trap in traps:
		trap.died.connect(_on_player_died)
	
func _process(_delta: float) -> void:
	$HUD.update_level(level)
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
func _on_player_died():
	$HUD.update_deaths()
	StatManager.died_this_level = true
	
	if not has_checkpoint:
		score = 0
		
	for trap in traps:
		trap.trap_animation.pause()
		
	await get_tree().create_timer(1.0).timeout
	
	if not StatManager.is_reloading_scene:
		StatManager.deaths += 1
		get_tree().call_deferred("reload_current_scene")
		StatManager.is_reloading_scene = true
	elif StatManager.is_reloading_scene:
		return
	
func _on_player_win(number, location):
	if score == score_required and next_level != null:
		StatManager.has_checkpoint = false
		StatManager.died_this_level = false
		score = 0
		
		if number == 1:
			$Background.win_glow()
		elif number == 2:
			$Background.win_glow_2()
		elif number == 3:
			$Background.win_glow_3()
		elif number == 4:
			$Background.win_glow_4()
			
		await get_tree().create_timer(0.3).timeout
		$Player.fade_animation()
		await get_tree().create_timer(1.5).timeout
		StatManager.check_number = 0
		get_tree().change_scene_to_packed(next_level)
	elif score < score_required:
		if has_checkpoint:
			if number == 1 and _1_was_last == false:
				$Background.win_glow()
				_1_was_last = true
				_2_was_last = false
				_3_was_last = false
				_4_was_last = false
			elif number == 2 and _2_was_last == false:
				_1_was_last = false
				_2_was_last = true
				_3_was_last = false
				_4_was_last = false
				$Background.win_glow_2()
			elif number == 3 and _3_was_last == false:
				_1_was_last = false
				_2_was_last = false
				_3_was_last = true
				_4_was_last = false
				$Background.win_glow_3()
			elif number == 4 and _4_was_last == false:
				_1_was_last = false
				_2_was_last = false
				_3_was_last = false
				_4_was_last = true
				$Background.win_glow_4()
			StatManager.check_number = number
			StatManager.coins_collected.append_array(coins_collected)
			StatManager.checkpoint_score = score
			StatManager.player_position = location

func _on_coin_collected(coin_name):
	score += 1
	coins_collected.append(coin_name)
	$HUD.update_score(score, score_required)
