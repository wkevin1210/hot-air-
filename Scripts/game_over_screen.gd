extends Control

@onready var score = %Player.points
var highscore = 0
var save_path = "user://score.save"

func save_score():
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(highscore)
	
func load_score():
	if FileAccess.file_exists(save_path):
		print("file found")
		var file = FileAccess.open(save_path, FileAccess.READ)
		highscore = file.get_var()
	else:
		highscore = score
		save_score()

func _on_player_death() -> void:
	visible = true
	score = %Player.points
	
	load_score()
	if score > highscore:
		highscore = score
		save_score()

	$Score.text = "Score: " + str(score)
	$HighScore.text = "High Score: " + str(highscore)



func _on_back_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
