extends Area2D

signal win(decider, checkpoint)

@export var number: int = 0
@onready var location: Vector2 = self.global_position
var win_exited: bool = false

func _ready() -> void:
	$CollisionShape2D.disabled = true
	await get_tree().create_timer(0.03).timeout
	$CollisionShape2D.disabled = false

func _on_body_entered(body: Node2D) -> void:
	if StatManager.died_this_level == false and number == 1 and StatManager.has_checkpoint == true and not win_exited:
		StatManager.player_position = location
		return
	if body.is_in_group("player"):
		win.emit(number, location)


func _on_body_exited(_body: Node2D) -> void:
	win_exited = true
