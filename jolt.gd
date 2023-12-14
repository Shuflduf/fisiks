extends Node3D

var box = preload("res://rigid_body_3d.tscn")
# Called when the node enters the scene tree for the first time.
@onready var box_parent = $BoxParent
@onready var marker = $Marker3D
@onready var command_input = $CommandInput

@export var min := -100
@export var max := 100

signal new_box_spawn

func _physics_process(delta):
	var new_box = box.instantiate()

	new_box.position.x = marker.global_position.x + randf_range(max, min)
	new_box.position.y = marker.global_position.y + randf_range(max, min)
	new_box.position.z = marker.global_position.z + randf_range(max, min)
	#new_box.rotation.z = randf_range(180, -180)
	box_parent.add_child(new_box)
	emit_signal("new_box_spawn")

func _on_area_3d_body_entered(body):
	body.queue_free()
