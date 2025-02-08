extends Node3D

const POINT = preload("res://Scenes/checkpoint.tscn")

func _ready():
	randomize()

func spawn_checkpoint():
	var checkpoint = POINT.instantiate()
	
	add_child(checkpoint)
	checkpoint.collected.connect(_on_checkpoint_collected)
	checkpoint.spawn()

func _on_checkpoint_collected() -> void:

	call_deferred("spawn_checkpoint")
