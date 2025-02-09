extends CanvasLayer



func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")



func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_controls_pressed() -> void:
	$MainMenu.visible = false
	$ControlsMenu.visible = true


func _on_back_pressed() -> void:
	$MainMenu.visible = true
	$ControlsMenu.visible = false
