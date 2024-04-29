extends CharacterBody3D
#
const SPEED = 5
const ACCELERATION = 6
const ROTATION_FORCE = 7
const JUMP_FORCE = 20  # Adjust this value to control the jump height
const GRAVITY = -50

var is_jumping = false
var trickeable = true
var holding_manual = false
var can_manual = true
var can_nosemanual = true

@onready var text_label = get_node("../UI/Label")

func _ready():
	floor_max_angle = deg_to_rad(90)
	
func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var desired_direction = Vector3(direction.x, 0, direction.y)
	velocity = lerp(velocity, desired_direction * SPEED, delta * ACCELERATION)
	if desired_direction.length() > 0:
		var desired_rotation = atan2(-desired_direction.x, -desired_direction.z)
		rotation.y = lerp_angle(rotation.y, desired_rotation, ROTATION_FORCE * delta)
		if is_on_floor():
			_tilt()
	

	
	if is_on_floor():
		velocity.y = 0
		
	else:
		velocity.y += GRAVITY * delta
		rotation = Vector3(0,rotation.y,0)
		
	
	if is_jumping and is_on_floor():
		velocity.y = JUMP_FORCE
		is_jumping = false
	
	move_and_slide()

func _process(delta):
	
	if can_manual:
		if Input.is_action_just_pressed("LT"):
			holding_manual = true
			can_nosemanual = false
			$Tricks/ManualTimer.start()
			text_label.update_label_text("MANUAL")
		if Input.is_action_pressed("LT") and holding_manual:
			$Tricks/AnimationPlayer.play("Manual")
		if Input.is_action_just_released("LT"):
			holding_manual = false
			can_nosemanual = true
			
	
	if can_nosemanual:
		if Input.is_action_just_pressed("RT"):
			holding_manual = true
			can_manual = false
			$Tricks/ManualTimer.start()
			text_label.update_label_text("NOSEMANUAL")
		if Input.is_action_pressed("RT") and holding_manual:
			$Tricks/AnimationPlayer.play("Nosemanual")
		if Input.is_action_just_released("RT"):
			holding_manual = false
			can_manual = true
			
			
	if trickeable:
		
		if Input.is_action_just_pressed("ollie"):
			trick()
		
		
		if Input.is_action_just_pressed("flip_trick") and !Input.is_action_pressed("LB") and !Input.is_action_pressed("RB"):
			$Tricks/AnimationPlayer.play("Kickflip")
			text_label.update_label_text("KICKFLIP")
			trick()
			
		if Input.is_action_just_pressed("shove_trick") and !Input.is_action_pressed("LB") and !Input.is_action_pressed("RB"):
			$Tricks/AnimationPlayer.play("ShoveIt")
			text_label.update_label_text("SHOVE-IT")
			trick()
		
		if Input.is_action_just_pressed("shove_trick") and Input.is_action_pressed("LB"):
			$Tricks/AnimationPlayer.play("360ShoveIt")
			text_label.update_label_text("360 SHOVE-IT")
			trick()
		
		if Input.is_action_just_pressed("flip_trick") and Input.is_action_pressed("LB"):
			$Tricks/AnimationPlayer.play("VarialHeel")
			text_label.update_label_text("VARIALHEEL")
			trick()
		
		if Input.is_action_just_pressed("flip_trick") and Input.is_action_pressed("RB"):
			$Tricks/AnimationPlayer.play("360flip")
			text_label.update_label_text("360FLIP")
			trick()
		
		if Input.is_action_just_pressed("shove_trick") and Input.is_action_pressed("RB"):
			$Tricks/AnimationPlayer.play("Impossible")
			text_label.update_label_text("IMPOSSIBLE")
			trick()
		
	
	


func _tilt():
		var normal = get_floor_normal()
		# Calculate rotation angles around X and Z axesw
		var rotation_angle_x = atan2(normal.x, normal.y)  # Ángulo alrededor del eje X
		var rotation_angle_z = atan2(normal.x, normal.y)  # Ángulo alrededor del eje Z
		
		# Aplicar la rotación al personaje
		rotation.x = rotation_angle_x
		rotation.z = rotation_angle_z

func trick():
	is_jumping = true
	$Tricks/Timer.start()
	trickeable = false
	holding_manual = false


func _on_timer_timeout():
	trickeable = true


func _on_manual_timer_timeout():
	holding_manual = false
