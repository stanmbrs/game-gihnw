extends Area2D

signal game_over

func _on_Spikes_body_entered(body):
	var body_name = body.get_name()
	if body_name == "Player":
		emit_signal("game_over")
		$CollisionShape2D.disabled = true

func start():
	$CollisionShape2D.disabled = false
