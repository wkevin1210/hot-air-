extends Node

@export var balloon : PackedScene

func spawn_ballloon():
	var balloons : RigidBody3D = balloon.instantiate()
	%Holder.add_child(balloons)
	balloons.global_position = %Player.global_position + Vector3(randf_range(-100,100), randf_range(-50, -40), randf_range(-100,100))


func _on_timer_timeout() -> void:
	spawn_ballloon()
