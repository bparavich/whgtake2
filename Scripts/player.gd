extends CharacterBody2D
class_name Player

@export var SPEED = 135.0
@export var alive: bool 

func set_player_postion(has_checkpoint):
	#if there is a vector saved from a checkpoint, sets player to that location
	if has_checkpoint:
		position = StatManager.player_position
	
func _physics_process(_delta: float) -> void:
	move_player()
	
	mute()
	
	move_and_slide()

func move_player():
	#moves player in proper direction based on its vector
	if alive and get_tree().paused == false:
		var direction: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = direction * SPEED
	else:
		#if player dies they wont be able to move
		velocity = Vector2.ZERO
		
func die():
	#ensures that the death sound doesnt play twice if multiple traps making contact
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
	alive = false
	fade_animation()
	
func fade_animation():
	#fades player for death
	$AnimationPlayer.play("fade")
	
func mute():
	#mutes the death sound of player and unmutes depending
	if StatManager.muted == true:
		$AudioStreamPlayer.volume_db = -80
	elif StatManager.muted == false:
		$AudioStreamPlayer.volume_db = 0
