extends Node2D


func _ready() -> void:
	$AnimationPlayer.play("inner_rotation")
	$AnimationPlayer2.play("outer_rotation")
