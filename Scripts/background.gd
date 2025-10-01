extends Node2D

@onready var glow_animation: AnimationPlayer = $GlowAnimation

@onready var win_glow_rects = get_tree().get_nodes_in_group("win_glow")
@onready var win_glow_anis = get_tree().get_nodes_in_group("win_animation")
	
func win_glow(number):
	#Reveals and plays the proper animation correlated to the win_area entered
	var win_glow_rect = win_glow_rects[number - 1]
	win_glow_rect.visible = true
	var win_glow_ani = win_glow_anis[number - 1]
	win_glow_ani.play("win_glow")
	
func start_glow():
	#Plays the glow animation where ever the player starts
	$StartGlow.visible = true
	glow_animation.play("start_glow")
