extends Camera3D

const FOLLOW_FORCE = 8

func _process(delta):
	if $"../Player":
		position = lerp(position, $"../Player".position + Vector3(-2, 10, 10), delta * FOLLOW_FORCE)
	else:
		position
