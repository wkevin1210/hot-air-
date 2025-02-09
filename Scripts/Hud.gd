extends Control

@onready var player : CharacterBody3D = get_tree().get_first_node_in_group("Player")
@export var speed_bar : ProgressBar
@export var health : TextureRect

@export var hp_2 : CompressedTexture2D
@export var hp_1 : CompressedTexture2D

func _ready() -> void:
	speed_bar.value = player.forward_speed
	player.connect("speed_change", speed_change)
	player.connect("health_change", hp_change)
	
func speed_change(speed):
	speed_bar.value = speed

func hp_change(hp):
	if hp == 2: 
		health.texture = hp_2
	if hp == 1:
		health.texture = hp_1
