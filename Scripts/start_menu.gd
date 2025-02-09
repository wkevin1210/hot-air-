extends CanvasLayer



func _on_start_button_pressed() -> void:
	%Popping.playing = true
	await %Popping.finished
	get_tree().change_scene_to_file("res://Scenes/game.tscn")



func _on_quit_pressed() -> void:
	%Popping.playing = true
	await %Popping.finished
	get_tree().quit()


func _on_controls_pressed() -> void:
	%Popping.playing = true
	$MainMenu.visible = false
	$ControlsMenu.visible = true


func _on_back_pressed() -> void:
	%Popping.playing = true
	$MainMenu.visible = true
	$ControlsMenu.visible = false


func _on_audio_pressed() -> void:
	%Popping.playing = true
	$AudioMenu.visible = true
	$MainMenu.visible = false


func _on_back_2_pressed() -> void:
	%Popping.playing = true
	$AudioMenu.visible = false
	$MainMenu.visible = true
