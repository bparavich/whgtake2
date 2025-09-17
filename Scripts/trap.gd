extends Node2D

@export var animation: String = "blank"
@onready var trap_animation: AnimationPlayer = $Trap/TrapAnimation

signal died

func _ready() -> void:
	if animation != "blank":
		trap_animation.play(animation)


func _on_trap_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.die()
		died.emit()
