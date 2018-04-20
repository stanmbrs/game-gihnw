extends RigidBody2D

var speed = 1000
var velocity = Vector2()

func start(pos, dir):
	position = pos
	rotation = dir
	velocity = Vector2(speed, 0).rotated(dir)

func _physics_process(delta):
	position += velocity * delta

func _on_Bullet_body_entered(body):
	print(body)
	queue_free() # Destroy the bullet
	
	var body_name = body.get_name()
	if body_name == "Player":
		get_node("/root/Main").call("game_over")
	elif body_name == "MobTurret":
		if body.has_method("hit_by_bullet"):
			body.call("hit_by_bullet")

