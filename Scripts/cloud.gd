extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(.1).timeout
	%GPUParticles3D.visible = true
