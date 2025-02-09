extends CharacterBody3D

@export var max_speed = 20.0
@export var min_speed = 2.0
@export var accel = 0.6
@export var pitch_speed = 1.5
@export var roll_speed = 1.5
@export var yaw_speed = 1.0
@export var input_response = 5.0

@export var forward_speed = 5.0
var pitch_input = 0.0
var roll_input = 0.0
var yaw_input = 0.0

#Player stats / Hud Info & signals
@export var hp = 1
@export var points = 0
signal score_change(int)
signal speed_change(float)

func get_input(delta):
	if Input.is_action_pressed("throttle_up"):
		forward_speed = lerp(forward_speed, max_speed, accel * delta)
		speed_change.emit(forward_speed)
	if Input.is_action_pressed("throttle_down"):
		forward_speed = lerp(forward_speed, min_speed, accel * delta)
		speed_change.emit(forward_speed)
	pitch_input = lerp(pitch_input,
		Input.get_action_strength("pitch_up") - Input.get_action_strength("pitch_down"),
		input_response * delta)
	roll_input = lerp(roll_input,
		Input.get_action_strength("roll_left") - Input.get_action_strength("roll_right"),
		input_response * delta)
	yaw_input = lerp(yaw_input,
		Input.get_action_strength("yaw_left") - Input.get_action_strength("yaw_right"),
		input_response * delta)
	
var mouse_y = 0.0
var mouse_x = 0.0
var target_x = 0.0
var target_y = 0.0
var mouse_moving = false

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			mouse_moving = true
			target_y = -event.relative.y
			target_x = -event.relative.x
		

var mouse_accel = 3.0
var mouse_deccel = 10.0

func _physics_process(delta: float) -> void:
	get_input(delta)
	transform.basis = transform.basis.rotated(transform.basis.z, roll_input * roll_speed * delta)
	transform.basis = transform.basis.rotated(transform.basis.x, pitch_input * pitch_speed * delta)
	transform.basis = transform.basis.rotated(transform.basis.y, yaw_input * yaw_speed * delta)
	
	if mouse_moving:
		mouse_y = lerp(mouse_y, target_y, mouse_accel * delta)
		mouse_x = lerp(mouse_x, target_x, mouse_accel * delta)
	else:
		mouse_y = lerp(mouse_y, 0.0, mouse_deccel * delta)
		mouse_x = lerp(mouse_x, 0.0, mouse_deccel * delta)
		
	if abs(mouse_x) <= 3 or abs(mouse_y) <= 3:
		mouse_moving = false

	transform.basis = transform.basis.rotated(transform.basis.x, mouse_y * 0.0005)
	transform.basis = transform.basis.rotated(transform.basis.y, mouse_x * 0.0005)
	
	
	transform.basis = transform.basis.orthonormalized()
	velocity = -transform.basis.z * forward_speed
	move_and_collide(velocity * delta)

func damage():
	if hp > 0:
		hp -= 1
		health_change()
		if hp <= 0:
			call_deferred("destroy")

signal death
func destroy():
	emit_signal("death")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	visible = false


func add_point():
	points += 1
	score_change.emit(points)
	if %Timer.wait_time > .02:
		%Timer.wait_time = %Timer.wait_time - .02
		print(%Timer.wait_time)

func health_change():
	if hp == 2:
		%right._startColor = Color(0.871, 0.851, 0)
		%right._endColor = Color(0.871, 0.851, 0, 0)
		%left._startColor = Color(0.871, 0.851, 0)
		%left._endColor = Color(0.871, 0.851, 0, 0)
	if hp == 1: 
		%right._startColor = Color(0.784, 0, 0)
		%right._endColor = Color(0.784, 0, 0, 0)
		%left._startColor = Color(0.784, 0, 0)
		%left._endColor = Color(0.784, 0, 0, 0)
