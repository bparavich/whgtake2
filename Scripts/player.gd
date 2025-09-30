extends CharacterBody2D
class_name Player

@export var SPEED = 135.0
@export var alive: bool 

func set_player_postion(has_checkpoint):
	if has_checkpoint:
		position = StatManager.player_position
	
func _physics_process(_delta: float) -> void:
	move_player()
	
	mute()
	
	move_and_slide()

func move_player():
	if alive and get_tree().paused == false:
		var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = direction * SPEED
	else:
		velocity = Vector2.ZERO
		
func die():
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
	alive = false
	fade_animation()
	
func fade_animation():
	$AnimationPlayer.play("fade")
	
func mute():
	if StatManager.muted == true:
		$AudioStreamPlayer.volume_db = -80
	elif StatManager.muted == false:
		$AudioStreamPlayer.volume_db = 0
