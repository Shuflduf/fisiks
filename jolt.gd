extends Node3D

var shape := preload("res://shapes/box_box.tscn")

const BOX_BOX = preload("res://shapes/box_box.tscn")
const BOX_SPHERE = preload("res://shapes/box_sphere.tscn")
const SPHERE_BOX = preload("res://shapes/sphere_box.tscn")
const SPHERE_SPHERE = preload("res://shapes/sphere_sphere.tscn")

# Called when the node enters the scene tree for the first time.
@onready var box_parent = $BoxParent
@onready var marker = $Marker3D
@onready var command_input = $CommandInput

@export var spread := 2

signal set_square_mesh
signal set_square_coll
signal set_sphere_mesh
signal set_sphere_coll

signal new_box_spawn

func _physics_process(delta):
	var new_box = shape.instantiate()

	new_box.position.x = marker.global_position.x + randf_range(spread, -spread)
	new_box.position.y = marker.global_position.y + randf_range(spread, -spread)
	new_box.position.z = marker.global_position.z + randf_range(spread, -spread)
	
	new_box.rotation.z = randf_range(180, -180)
	new_box.rotation.x = randf_range(180, -180)
	new_box.rotation.y = randf_range(180, -180)
	
	box_parent.add_child(new_box)
	emit_signal("new_box_spawn")

func _on_area_3d_body_entered(body):
	body.queue_free()

#region stuff

func _ready():
#region shape change
	command_input.square_coll_button.connect(func():
		if shape == SPHERE_SPHERE:
			shape = SPHERE_BOX
		elif shape == BOX_SPHERE:
			shape = BOX_BOX
	)
	command_input.sphere_coll_button.connect(func():
		if shape == SPHERE_BOX:
			shape = SPHERE_SPHERE
		elif shape == BOX_BOX:
			shape = BOX_SPHERE
	)
	command_input.square_mesh_button.connect(func():
		if shape == SPHERE_SPHERE:
			shape = BOX_SPHERE
		elif shape == SPHERE_BOX:
			shape = BOX_BOX
	)
	command_input.sphere_mesh_button.connect(func():
		if shape == BOX_SPHERE:
			shape = SPHERE_SPHERE
		elif shape == BOX_BOX:
			shape = SPHERE_BOX
	)

#endregion
	command_input.reset_button.connect(func():
		for child in box_parent.get_children():
			child.queue_free()
	)
