extends CharacterBody3D

@export var max_speed = 10.0
@export var min_speed = 2.0
@export var accel = 0.6
@export var pitch_speed = 1.5
@export var roll_speed = 1.5
@export var yaw_speed = 1.0
@export var input_response = 5.0
@export var hp = 3
var point = 0

@export var forward_speed = 5.0
var pitch_input = 0.0
var roll_input = 0.0
var yaw_input = 0.0


func get_input(delta):
	if Input.is_action_pressed("throttle_up"):
		forward_speed = lerp(forward_speed, max_speed, accel * delta)
	if Input.is_action_pressed("throttle_down"):
		forward_speed = lerp(forward_speed, min_speed, accel * delta)
	pitch_input = lerp(pitch_input,
		Input.get_action_strength("pitch_up") - Input.get_action_strength("pitch_down"),
		input_response * delta)
	roll_input = lerp(roll_input,
		Input.get_action_strength("roll_left") - Input.get_action_strength("roll_right"),
		input_response * delta)
	yaw_input = lerp(yaw_input,
		Input.get_action_strength("yaw_left") - Input.get_action_strength("yaw_right"),
		input_response * delta)
		
func _physics_process(delta: float) -> void:
	get_input(delta)
	transform.basis = transform.basis.rotated(transform.basis.z, roll_input * roll_speed * delta)
	transform.basis = transform.basis.rotated(transform.basis.x, pitch_input * pitch_speed * delta)
	transform.basis = transform.basis.rotated(transform.basis.y, yaw_input * yaw_speed * delta)
	transform.basis = transform.basis.orthonormalized()
	velocity = -transform.basis.z * forward_speed
	move_and_collide(velocity * delta)

func damage():
	if hp > 0:
		hp -= 1
		if hp <= 0:
			call_deferred("destroy")

func destroy():
	get_tree().reload_current_scene()

func add_point():
	point += 1
	if %Timer.wait_time > .2:
		%Timer.wait_time = %Timer.wait_time - .05
