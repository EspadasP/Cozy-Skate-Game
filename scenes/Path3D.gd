extends Path3D

var sumprogress = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$PathFollow3D.set_process(false)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if($PathFollow3D.progress_ratio < 1.0):
		sumprogress += 0.01 
		$PathFollow3D.progress_ratio = sumprogress
	#print($PathFollow3D.progress_ratio)
	


func _on_collision_grind_body_entered(body):
	var global_collision_position = body.global_transform.origin
	var local_collision_position = to_local(global_collision_position)
	#var progress_ratio = local_collision_position.x / collision_shape_size_x
	#$PathFollow3D.progress_ratio = progress_ratio
	print(local_collision_position)
	
	$PathFollow3D.set_process(true)
	$PathFollow3D.progress = 0
		#$PathFollow3D.offset = 0.0
		#$PathFollow3D.set_offset(0)
		
		# Ajusta la posición del PathFollow3D al punto de colisión
		#var collision_point = $"../CollisionGrind".global_transform.origin
		# Haz ajustes adicionales según la posición específica del punto de colisión si es necesario
		# Por ejemplo, puedes querer que el PathFollow3D se mueva ligeramente hacia adelante o hacia atrás a partir del punto de colisión
		#$PathFollow3D.translation = collision_point
