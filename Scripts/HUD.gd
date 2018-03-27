extends CanvasLayer

signal start_game

func _ready():
	$MessageLabel.hide()

func show_message(text):
	$MessageTimer.stop()
	$MessageLabel.text = text
	$MessageLabel.show()

func show_game_over():
	show_message("Game Over")
	$StartButton.show()

func update_score(score):
    $TimeScoreLabel.text = "Time: " + str(score)


func _on_StartButton_pressed():
	$StartButton.hide()
	show_message("Survive !")
	$MessageTimer.start()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$MessageLabel.hide()
