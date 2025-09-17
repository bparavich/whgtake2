extends Node2D

@onready var glow_animation: AnimationPlayer = $GlowAnimation

func win_glow():
	$WinGlow.visible = true
	glow_animation.play("win_glow")

func win_glow_2():
	$WinGlow2.visible = true
	$GlowAnimation2.play("win_glow")

func start_glow():
	$StartGlow.visible = true
	glow_animation.play("start_glow")
