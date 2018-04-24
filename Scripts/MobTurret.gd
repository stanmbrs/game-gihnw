extends KinematicBody2D

export (float) var GRAVITY
export (int) var DETECT_RADIUS  # size of the visibility circle
export (float) var FIRE_RATE  # delay time (s) between bullets
export (PackedScene) var BULLET

var target  # who are we shooting at?
var can_shoot = true
var velocity = Vector2()
var spawn_turret

func start(spawn):
	spawn_turret = spawn
	position = spawn.position
	can_shoot = false
	$ShootTimer.start()

func hit_by_bullet():
	get_node("/root/Main").set_spawn_available(spawn_turret)
	queue_free() # kill the mob

func shoot(pos):
	var shooter = get_instance_id()
	var b = BULLET.instance()
	var a = (pos - global_position).angle()
	b.start(global_position, a + rand_range(-0.05, 0.05), shooter)
	get_parent().add_child(b)
	can_shoot = false
	$ShootTimer.start()

func _ready():
	# set the collision area's radius
	var shape = CircleShape2D.new()
	shape.radius = DETECT_RADIUS
	$Visibility/CollisionShape2D.shape = shape
	$ShootTimer.wait_time = FIRE_RATE

func _physics_process(delta):
	update()
	if !is_on_floor():
		velocity.y += GRAVITY 
		velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if target:
		if can_shoot:
			shoot(target.position)

func _on_ShootTimer_timeout():
	can_shoot = true

func _on_Visibility_body_entered(body):
	if target:
		return
	target = body

func _on_Visibility_body_exited(body):
	if body == target:
		target = null
