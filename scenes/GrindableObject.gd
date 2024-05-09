extends Node3D

var grinding = false
var player = null
var skater = null
var path_follower = null
var grind_animation = null




func _ready():
	skater = get_tree().get_nodes_in_group("player")
	
	
	


func _process(delta):
	
	#print(grinding) 
	if Input.is_action_just_pressed("flip_trick") or Input.is_action_just_pressed("shove_trick") or Input.is_action_just_pressed("ollie"):
		grinding = false
		skater[0].stop_grind()
		path_follower = null
		skater[0].is_grinding(grinding)
	if grinding:
		skater[0].add_to_line(10)
		#var direction_degrees = rad_to_deg(atan2(skater[0].velocity.x, skater[0].velocity.z))
		#print(direction_degrees)
		skater[0].is_grinding(grinding)
		if global_transform.basis.z.z < 0.01 and global_transform.basis.z.z > -0.01: #esto significa que el objeto esta en horizontal
		#if -45 < direction_degrees and direction_degrees < 135:
		#atan2(skater[0].velocity.z, skater[0].velocity.x) > 0
			
			if skater[0].velocity.x > 0:
				path_following($Path3D/PathFollow3D/RigidBody3D, $Path3D)
			else:
				path_following($Path3Dleftdown/PathFollow3D/RigidBody3D, $Path3Dleftdown)
		else:
			
			if skater[0].velocity.z <= 0:
				
				path_following($Path3D/PathFollow3D/RigidBody3D, $Path3D)
			else:
				
				path_following($Path3Dleftdown/PathFollow3D/RigidBody3D, $Path3Dleftdown)	
		
#func grindout():
	#grinding = false

func _on_collision_grind_body_entered(body):
	if Input.is_action_just_pressed("grind") or Input.is_action_pressed("grind") or  Input.is_action_just_released("grind"):
		$Path3D/PathFollow3D.set_process(true)
		$Path3Dleftdown/PathFollow3D.set_process(true)
		$Path3Dleftdown/PathFollow3D.progress = 0
		$Path3D/PathFollow3D.progress = 0
		
		player = body
		grinding = true
		skater[0].play_grind()

func path_following(path_follower, path):
	if path_follower:
		var destination_position = path_follower.get_global_transform().origin 
		player.global_transform.origin = player.global_transform.origin.lerp(destination_position, 0.8)
	grinding = true
				
	 

		
		
			
