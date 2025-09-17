extends CharacterBody2D
class_name Player

@export var SPEED = 300.0
var alive: bool = true

func set_player_postion(has_checkpoint):
	if has_checkpoint:
		position = StatManager.player_position
	
func _physics_process(_delta: float) -> void:
	move_player()
	
	move_and_slide()

func move_player():
	if alive:
		var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
		
func die():
	alive = false
	fade_animation()
	
func fade_animation():
	$AnimationPlayer.play("fade")
