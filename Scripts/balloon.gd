extends RigidBody3D

@export var balloon : MeshInstance3D
@onready var speed : float = randf_range(0.2, 0.3)
var colors : Array = [(Color(0, 0.804, 0.965, 0.894)),(Color(0.794, 0.192, 0.448, 0.894)),(Color(0.086, 0.553, 0.075, 0.894)),(Color(0.886, 0.793, 0.202, 0.894)),(Color(0.748, 0.14, 0.812, 0.894))]

func _ready() -> void:
	var color = randi_range(0,4)
	var material : StandardMaterial3D = balloon.get_surface_override_material(0)
	material.albedo_color = colors[color]
	

func _physics_process(_delta: float) -> void:
	global_position = global_position + Vector3(0, speed, 0)
	if global_position.y > 100:
		queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		body.damage()
		destroy()

func destroy():
	balloon.visible = false
	%AudioStreamPlayer3D.playing = true

func _on_audio_stream_player_3d_finished() -> void:
	queue_free()
