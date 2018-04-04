extends KinematicBody2D

export (float) var GRAVITY
export (int) var DETECT_RADIUS  # size of the visibility circle
export (float) var FIRE_RATE  # delay time (s) between bullets

func _physics_process(delta):
	velocity.y += GRAVITY 
	velocity = move_and_slide(velocity, Vector2(0, -1))