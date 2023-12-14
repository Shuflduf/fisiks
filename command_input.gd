extends Control

@onready var object_count_label = $CommandCanvas/ObjectCount

var object_count := 0

func _on_jolt_new_box_spawn():
	object_count += 1
	object_count_label.text = "Objects: " + str(object_count)
