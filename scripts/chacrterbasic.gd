extends CharacterBody3D

@export var speed : int

func _physics_process(delta):
	var movement_dir = Input.get_vector("left","right","down","up")
	var z_dir = Input.get_axis("left_mouse","right_mouse")
	position.x += movement_dir.x * delta * speed
	position.y -= z_dir * delta * speed
	position.z -= movement_dir.y * delta * speed
	
	position.y = clamp(position.y, -3, 30)
	position.x = clamp(position.x, -40, 40)
	position.z = clamp(position.z, -40, 40)
