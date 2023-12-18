extends Label


func _input(event):
	if event.is_action_pressed("cycle_debug_menu"):
		visible = false
