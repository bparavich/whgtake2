extends Path2D

@export var speed: float = 0.1
@export var placement: int = 0
@onready var traps_2: Node2D = $"../../Traps2"

func _ready() -> void:
	$PathFollow2D.progress_ratio = placement * 0.0191
	if get_parent() == traps_2:
		$PathFollow2D.progress_ratio += 0.4971

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$PathFollow2D.progress_ratio += delta * speed
