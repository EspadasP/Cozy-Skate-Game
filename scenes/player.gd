extends CharacterBody3D
#
const SPEED = 5
const ACCELERATION = 6
const ROTATION_FORCE = 7
const JUMP_FORCE = 20  # Adjust this value to control the jump height
const GRAVITY = -50


var is_jumping = false
var trickeable = true


func _ready():
	floor_max_angle = deg_to_rad(90)
	
func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var desired_direction = Vector3(direction.x, 0, direction.y)
	velocity = lerp(velocity, desired_direction * SPEED, delta * ACCELERATION)
	if desired_direction.length() > 0:
		var desired_rotation = atan2(-desired_direction.x, -desired_direction.z)
		rotation.y = lerp_angle(rotation.y, desired_rotation, ROTATION_FORCE * delta)

	
	print(get_floor_normal())
	
	if is_on_floor():
		velocity.y = 0
		_tilt()
	else:
		velocity.y += GRAVITY * delta
		
	
	if is_jumping and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = false
	
	move_and_slide()

func _process(_delta):
	
	if trickeable:
		
		if Input.is_action_pressed("LT") and is_jumping:
			print("en el aire")
			rotation_degrees.y += 180
		
		if Input.is_action_just_pressed("flip_trick"):
			$Tricks/AnimationPlayer.play("Kickflip")
			is_jumping = true
			$Tricks/Timer.start()
			trickeable = false
		
		if Input.is_action_just_pressed("ollie"):
			is_jumping = true
			$Tricks/Timer.start()
			trickeable = false
		
		if Input.is_action_pressed("LB") and Input.is_action_just_pressed("flip_trick"):
			print("haciendo360flip")
			$Tricks/AnimationPlayer.play("360flip")
			is_jumping = true
			$Tricks/Timer.start()
			trickeable = false
		
	
	
@onready var raycast = $RayCast3D

func _tilt():
	if is_on_floor() and raycast.is_colliding():
		var normal = raycast.get_collision_normal()
		var rotation_angle = atan2(normal.z, normal.y) # Calculate the angle around X-axis
		rotation_degrees.x = rad_to_deg(rotation_angle) # Convert radians to degrees




func _on_timer_timeout():
	trickeable = true
