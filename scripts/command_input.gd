extends Control

var box = preload("res://scenes/rigid_body_3d.tscn")


@onready var square_mesh = %SquareMesh
@onready var square_coll = %SquareColl
@onready var sphere_mesh = %SphereMesh
@onready var sphere_coll = %SphereColl
@onready var reset = %Reset
@onready var reset_camera = %ResetCamera
@onready var scale_slider = $CommandCanvas/ScaleSlider
@onready var objects = $CommandCanvas/PanelContainer/Objects

@export var sensitivity := 4.0

signal square_mesh_button
signal square_coll_button
signal sphere_mesh_button
signal sphere_coll_button

signal reset_button
signal reset_camera_button
signal change_scale(value)

var object_count := 0
	
func _ready():
#region signals

	sphere_mesh.pressed.connect(func():
		emit_signal("sphere_mesh_button")
	)
	square_mesh.pressed.connect(func():
		emit_signal("square_mesh_button")	
	)
	square_coll.pressed.connect(func():
		emit_signal("square_coll_button")	
	)
	sphere_coll.pressed.connect(func():
		emit_signal("sphere_coll_button")	
	)

#endregion
	reset.pressed.connect(func():
		emit_signal("reset_button")
		object_count = 0
	)
	reset_camera.pressed.connect(func():
		emit_signal("reset_camera_button")	
	)

func _on_scale_slider_value_changed(value):
	emit_signal("change_scale",value)

func _physics_process(_delta):
	object_count += 1
	objects.text = str(object_count) + " Objects"

func _on_jolt_delete_box():
	object_count -= 1
