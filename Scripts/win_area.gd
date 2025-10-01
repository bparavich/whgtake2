extends Area2D

signal win(decider, checkpoint)

@export var number: int = 0
@onready var location: Vector2 = self.global_position
var win_exited: bool = false

func _ready() -> void:
	#prevents multiple collisions happening right on spawn
	$CollisionShape2D.disabled = true
	await get_tree().create_timer(0.03).timeout
	$CollisionShape2D.disabled = false

func _on_body_entered(body: Node2D) -> void:
	#this first check is to make sure the start area doesnt play a glow animation on first spawn
	if StatManager.died_this_level == false and number == 1 and StatManager.has_checkpoint == true and not win_exited:
		StatManager.player_position = location
		return
	if body.is_in_group("player"):
		#sends a signal to level that will handle saving the location for the player to use on a checkpoint level and also which win_area was entered to play proper animation
		win.emit(number, location)


func _on_body_exited(_body: Node2D) -> void:
	win_exited = true
