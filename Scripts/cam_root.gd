extends Node3D

var cam_speed = 20

func _physics_process(delta: float) -> void:
	global_position = %Player.global_position
	rotation_degrees.y = rad_to_deg(lerp_angle(deg_to_rad(rotation_degrees.y),
			deg_to_rad(%Player.rotation_degrees.y), cam_speed*delta))
	rotation_degrees.x = rad_to_deg(lerp_angle(deg_to_rad(rotation_degrees.x),
			deg_to_rad(%Player.rotation_degrees.x), cam_speed*delta))
	rotation_degrees.z = rad_to_deg(lerp_angle(deg_to_rad(rotation_degrees.z),
			deg_to_rad(%Player.rotation_degrees.z), cam_speed*delta))
