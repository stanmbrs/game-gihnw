extends KinematicBody2D

export (float) var GRAVITY
export (float) var WALK_SPEED
export (float) var JUMP_SPEED

var velocity = Vector2()

func _ready():
	hide()

func _physics_process(delta):
	
	velocity.y += GRAVITY 
	
	var walk_left = Input.is_action_pressed("move_left")
	var walk_right = Input.is_action_pressed("move_right")
	var jump = Input.is_action_just_pressed("jump")
	
	if walk_left:
		velocity.x = -WALK_SPEED
	elif walk_right:
		velocity.x = WALK_SPEED
	else:
		velocity.x = 0
	
	if jump and is_on_floor():
		velocity.y = -JUMP_SPEED
	
	velocity = move_and_slide(velocity, Vector2(0, -1))

func start(pos):
	show()
	position = pos


