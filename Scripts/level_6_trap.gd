extends Node2D

var _rotation: float
@export var rotate_right: bool = true

func _process(_delta: float) -> void:
	if rotate_right == true:
		_rotation += .031
	elif rotate_right == false:
		_rotation -= .031
	$Trap.set_rotation(_rotation)
