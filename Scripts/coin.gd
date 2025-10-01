extends Area2D


signal coin_collected(coin: String)

@export var glow_delay: float

func _ready() -> void:
	if StatManager.coins_collected.has(self.name): #Checks to see if this coin was collected already on a checkpoint level
		queue_free()
	await get_tree().create_timer(glow_delay).timeout
	$GlowAnimation.play("glow") #Waits a certain amount of time then glows, random to offset the glowing
	
func _process(_delta: float) -> void: #This constantly checks if the game is muted and sets the volume appropriately to achieve this
	if StatManager.muted == true:
		$AudioStreamPlayer.volume_db = -80
	elif StatManager.muted == false:
		$AudioStreamPlayer.volume_db = 0
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"): #Here we make sure its the player entering the area
		$AudioStreamPlayer.play() #then we play the coin collected sound
		$GlowAnimation.stop() #stop its animation
		$CollisionShape2D.queue_free() #and get rid of the collision shape incase it triggers twice
		var tween = create_tween()
		tween.tween_property($Main, "modulate:a", 0.0, 0.3) #then tween out the coin sprite for a fade
		coin_collected.emit(self.name)
