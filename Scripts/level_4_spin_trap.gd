extends Node2D

var current_death: int = 0

@onready var trap_animation: AnimationPlayer = $TrapAnimation

func _ready() -> void:
	trap_animation.play("spin")
