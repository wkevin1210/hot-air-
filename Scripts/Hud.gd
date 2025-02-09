extends Control

@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("Player")
@export var speed_bar : ProgressBar


func _ready() -> void:
	speed_bar.value = player.forward_speed
	player.connect("speed_change", speed_change)
	
func speed_change(speed):
	speed_bar.value = speed
