extends Area3D

@onready var player : CharacterBody3D = get_parent().get_node("Player")

func _process(_delta: float) -> void:
	if player != null:
		look_at(player.global_position)

func spawn():
	add_to_group("Checkpoints")
	var offsets = []
	
	for i in range(3):
		var f = randf_range(20.0, 50.0)
		var n = randi() % 2
		if n == 0:
			f = -f
		offsets.append(f)
	
	global_position.x = player.global_position.x + offsets[0]
	global_position.y = randf_range(-60.0, 40.0)
	global_position.z = player.global_position.z + offsets[2]
	
signal collected
func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		set_deferred("monitoring", false)
		collected.emit()
		body.add_point()
		%AudioStreamPlayer.playing = true
		


func _on_audio_stream_player_finished() -> void:
	queue_free()
