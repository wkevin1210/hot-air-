extends AudioStreamPlayer

func _physics_process(_delta: float) -> void:
	pitch_scale = (%Player.forward_speed) * 0.1
	if pitch_scale > 1.2:
		pitch_scale = 1.2
	if pitch_scale < .8:
		pitch_scale = .8


func _on_player_death() -> void:
	playing = false
