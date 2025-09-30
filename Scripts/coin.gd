extends Area2D


signal coin_collected(coin: String)

@export var glow_delay: float

func _ready() -> void:
	if StatManager.coins_collected.has(self.name):
		queue_free()
	await get_tree().create_timer(glow_delay).timeout
	$GlowAnimation.play("glow")
	
func _process(_delta: float) -> void:
	if StatManager.muted == true:
		$AudioStreamPlayer.volume_db = -80
	elif StatManager.muted == false:
		$AudioStreamPlayer.volume_db = 0
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		$AudioStreamPlayer.play()
		$GlowAnimation.stop()
		$CollisionShape2D.queue_free()
		var tween = create_tween()
		tween.tween_property($Main, "modulate:a", 0.0, 0.3)
		coin_collected.emit(self.name)
