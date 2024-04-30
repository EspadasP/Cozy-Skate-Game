extends Node3D

var grinding = false
var player = null
var skater = null
var path_follower = null


func _ready():
	skater = get_tree().get_nodes_in_group("player")
	


func _process(delta):
	print(skater[0].velocity)
	
	if Input.is_action_just_pressed("flip_trick") or Input.is_action_just_pressed("shove_trick") or Input.is_action_just_pressed("ollie"):
		grinding = false
		path_follower = null
	if grinding:
		if skater[0].velocity.x >= 0 or skater[0].velocity.z >= 0:
		#atan2(skater[0].velocity.z, skater[0].velocity.x) > 0
			path_follower = $Path3D/PathFollow3D/RigidBody3D
			if path_follower:
				var destination_position = path_follower.get_global_transform().origin 
				player.global_transform.origin = destination_position
		else:
			path_follower = $Path3Dleftdown/PathFollow3D/RigidBody3D
			if path_follower:
				var destination_position = path_follower.get_global_transform().origin 
				player.global_transform.origin = destination_position
		
func grindout():
	grinding = false

func _on_collision_grind_body_entered(body):
	if Input.is_action_pressed("grind") or Input.is_action_just_pressed("grind") or Input.is_action_just_released("grind"):
		$Path3D/PathFollow3D.set_process(true)
		$Path3Dleftdown/PathFollow3D.set_process(true)
		$Path3Dleftdown/PathFollow3D.progress = 0
		$Path3D/PathFollow3D.progress = 0
		
		player = body
		grinding = true
		
		
		
			
