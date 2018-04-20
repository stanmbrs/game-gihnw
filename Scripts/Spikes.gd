extends Area2D


func _on_Spikes_body_entered(body):
	var body_name = body.get_name()
	if body_name == "Player":
		get_node("/root/Main").call("game_over")
		$CollisionShape2D.disabled = true

func start():
	$CollisionShape2D.disabled = false
