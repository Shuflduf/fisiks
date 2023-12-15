extends Node3D

var moving_camera := false
@export var sensitivity := 1.0
@onready var hpivot = $"."
@onready var vpivot = $VPivot
@onready var camera = $VPivot/Camera3D

@export var max_zoom_in := 10
@export var max_zoom_out := 500
@export var zoom_speed := 2

func _input(event):
	if event is InputEventMouseMotion and moving_camera:
		
		rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		
		vpivot.rotate_z(deg_to_rad(-event.relative.y * sensitivity))
		vpivot.rotation.z = clamp(vpivot.rotation.z, deg_to_rad(-89), deg_to_rad(0))
		
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP and camera.position.x < -max_zoom_in :
				camera.position.x += 1 * zoom_speed
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN and camera.position.x > -max_zoom_out :
				camera.position.x -= 1 * zoom_speed

		
func _physics_process(_delta):
	if Input.is_action_pressed("middle_mouse"):
		moving_camera = true
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		moving_camera = false
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_command_input_reset_camera_button():
	hpivot.rotation = Vector3(0, deg_to_rad(90), 0)
	vpivot.rotation = Vector3(0, 0, deg_to_rad(-30))
	camera.position.x = -30
