extends Node

@export var balloon : PackedScene

func spawn_ballloon():
	var balloons : RigidBody3D = balloon.instantiate()
	add_child(balloons)
	balloons.global_position = Vector3(randf_range(-20, 20), -40, randf_range(0, -30))


func _on_timer_timeout() -> void:
	spawn_ballloon()
