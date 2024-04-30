extends Path3D

var sumprogress = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$PathFollow3D.set_process(false)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$PathFollow3D.progress += 3 * delta
	
	#if $PathFollow3D.progress_ratio == 1:
		#$PathFollow3D.progress_ratio = 0
		
	
#

	

	
