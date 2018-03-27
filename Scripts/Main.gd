extends Node

var time_score

func game_over():
	$HUD.show_game_over()
	$TimeScoreTimer.stop()

func new_game():
	# Reset score
	time_score = 0
	$HUD.update_score(time_score)
	# Start player node 
	$Player.start($StartPosition.position)
	# Launch timer 
	$TimeScoreTimer.start()
	# Start spikes nodes
	$Spikes/SpikesX5.start()


func _on_TimeScoreTimer_timeout():
	time_score += 0.01
	$HUD.update_score(time_score)
