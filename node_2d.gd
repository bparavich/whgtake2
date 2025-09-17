extends Node2D


var list: Array[String] = ["a", "b", "c"]
var list2: Array[String] = ["d","e"]

func _ready() -> void:
	print(list)
	list.append_array(list2)
	print(list)
