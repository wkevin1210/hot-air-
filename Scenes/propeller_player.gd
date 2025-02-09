extends AudioStreamPlayer

func _physics_process(delta: float) -> void:
	pitch_scale = (%Player.forward_speed) * 0.1
	if pitch_scale > 1.5:
		pitch_scale = 1.5



func _on_player_death() -> void:
	playing = false
