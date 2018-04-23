extends Area2D

export (int) var SPEED
var velocity = Vector2()
var shooter = null 

func start(pos, dir, shooter_id):
	position = pos
	rotation = dir
	shooter = shooter_id
	velocity = Vector2(SPEED, 0).rotated(dir)

func _physics_process(delta):
	position += velocity * delta

func _on_Bullet_body_entered(body):
	var body_name = body.get_name()
	if shooter != body.get_instance_id():
		if body_name == "Player":
			get_node("/root/Main").call("game_over")
		if body.has_method("hit_by_bullet"):
			body.call("hit_by_bullet")
		queue_free() # Destroy the bullet


