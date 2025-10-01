extends Node2D

@export var animation: String = "blank"
@onready var trap_animation: AnimationPlayer = $Trap/TrapAnimation

signal died

func _ready() -> void:
	#plays whatever animation is loaded into the trap
	trap_animation.play(animation)


func _on_trap_body_entered(body: Node2D) -> void:
	#if making contact with player, calls the die function on the player and emits a signal to the level script to perfrom tasks
	if body.is_in_group("player"):
		body.die()
		died.emit()
