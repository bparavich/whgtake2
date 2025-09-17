extends Node

var deaths: int = 0
var died_this_level: bool
var player_position: Vector2 = Vector2.ZERO
var coins_collected: Array[String] = []
var checkpoint_score: int = 0
var has_checkpoint: bool
var check_number: int
var is_reloading_scene: bool = false
