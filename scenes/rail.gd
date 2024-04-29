extends MeshInstance3D

var grinding = false
var player = null
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ollie",):
		grinding = false
	if grinding:
		var path_follower = $Path3D/PathFollow3D/RigidBody3D
		if path_follower:
			var destination_position = path_follower.get_global_transform().origin 
			player.global_transform.origin = destination_position
		


func _on_collision_grind_body_entered(body):
		player = body  # Accede al nodo que sigue el Path3D
		grinding = true
			
