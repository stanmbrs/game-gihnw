extends Node

var time_score

func start_spikes():
	# Resume execution the next frame
	yield(get_tree(), "idle_frame")
	# Start spikes nodes
	$Spikes/SpikesX5.start()

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
	# Restart spikes
	start_spikes()


func _on_TimeScoreTimer_timeout():
	time_score += $TimeScoreTimer.wait_time
	$HUD.update_score(time_score)
