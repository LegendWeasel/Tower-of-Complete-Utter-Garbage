extends Marker2D

func _process(delta):
	look_at(get_global_mouse_position())
	print(rotation_degrees)
