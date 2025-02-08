extends Node3D

func _physics_process(_delta: float) -> void:
	var checkpoints = get_tree().get_nodes_in_group("Checkpoints")

	if checkpoints != []:
		var target = checkpoints[0]
		look_at(target.global_position, Vector3.FORWARD)
