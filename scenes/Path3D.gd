extends Path3D

# Called when the node enters the scene tree for the first time.

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$PathFollow3D.progress += 3 * delta
	
	
#

	

	
