extends CharacterBody3D
const SPEED = 9
const ACCELERATION = 5
const ROTATION_FORCE = 7
const JUMP_FORCE = 20  # Adjust this value to control the jump height
const GRAVITY = -50


var counter = 0
var is_jumping = false
var trickeable = true
var holding_manual = false
var can_manual = true
var can_nosemanual = true
var scored_line = 0
var mult = 1
var isgrinding = false

signal grindout
@onready var ui = get_node("../UI/Label")

func _ready():
	floor_max_angle = deg_to_rad(89)
	
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
	if is_on_floor() and !isgrinding and !holding_manual:
		counter += 1
		if counter > 5: #algunos frames delta se "cuelan" de modo que con el contador nos aseguramos de que realmente ha acabado la linea
			end_line()
	else:
		counter = 0
	if can_manual:
		if Input.is_action_just_pressed("LT"):
			holding_manual = true
			can_nosemanual = false
			$Tricks/ManualTimer.start()
			ui.update_label_text("MANUAL")
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
			ui.update_label_text("NOSEMANUAL")
		if Input.is_action_pressed("RT") and holding_manual:
			$Tricks/AnimationPlayer.play("Nosemanual")
		if Input.is_action_just_released("RT"):
			holding_manual = false
			can_manual = true
			
			
	if trickeable:
		
		if Input.is_action_just_pressed("ollie") and !Input.is_action_pressed("LB") and !Input.is_action_pressed("RB"):
			$Tricks/AnimationPlayer.play("ollie")
			ui.update_label_text("OLLIE")
			trick()
			add_to_line(50)
			
		if Input.is_action_just_pressed("ollie") and Input.is_action_pressed("LB"):
			$Tricks/AnimationPlayer.play("ollie360")
			ui.update_label_text("OLLIE 360")
			trick()
			add_to_line(100)
		
		#if Input.is_action_just_pressed("ollie") and Input.is_action_pressed("RB"):
			#$Tricks/AnimationPlayer.play("backflip")
			#trick()
			#add_to_line(150)
		
		
		if Input.is_action_just_pressed("flip_trick") and !Input.is_action_pressed("LB") and !Input.is_action_pressed("RB"):
			$Tricks/AnimationPlayer.play("Kickflip")
			ui.update_label_text("KICKFLIP")
			trick()
			add_to_line(100)
			
		if Input.is_action_just_pressed("shove_trick") and !Input.is_action_pressed("LB") and !Input.is_action_pressed("RB"):
			$Tricks/AnimationPlayer.play("ShoveIt")
			ui.update_label_text("SHOVE-IT")
			trick()
			add_to_line(100)
		
		if Input.is_action_just_pressed("shove_trick") and Input.is_action_pressed("LB"):
			$Tricks/AnimationPlayer.play("360ShoveIt")
			ui.update_label_text("360 SHOVE-IT")
			trick()
			add_to_line(200)
		
		if Input.is_action_just_pressed("flip_trick") and Input.is_action_pressed("LB"):
			$Tricks/AnimationPlayer.play("VarialHeel")
			ui.update_label_text("VARIALHEEL")
			trick()
			add_to_line(200)
		
		if Input.is_action_just_pressed("flip_trick") and Input.is_action_pressed("RB"):
			$Tricks/AnimationPlayer.play("360flip")
			ui.update_label_text("360FLIP")
			trick()
			add_to_line(300)
		
		if Input.is_action_just_pressed("shove_trick") and Input.is_action_pressed("RB"):
			$Tricks/AnimationPlayer.play("Impossible")
			ui.update_label_text("IMPOSSIBLE")
			trick()
			add_to_line(300)
		
	
	


func _tilt():
		var normal = get_floor_normal()
		#print(velocity)
		#print(normal)
		#velocity += normal
		#print(velocity)
		
		var actualSize = self.scale
		var target_basis = Basis()
		target_basis.y = normal
		transform.basis.y = transform.basis.y.lerp(target_basis.y, 0.2)
		self.scale = actualSize
	
		
		
		#antiguo metodo de tilt 
		#var rotation_angle_x = atan2(normal.x, normal.y)  # Ángulo alrededor del eje X
		#var rotation_angle_z = atan2(normal.z, normal.y)  # Ángulo alrededor del eje Z
		#
		
		# Aplicar la rotación al personaje
		#if velocity.x > 0:
			#rotation.x = -rotation_angle_x
		#else:
			#rotation.x = rotation_angle_x
		#
		#if velocity.z > 0:
			#rotation.z = -rotation_angle_z
		#else:
			#rotation.z = rotation_angle_z
		

func trick():
	is_jumping = true
	$Tricks/Timer.start()
	trickeable = false
	holding_manual = false
	emit_signal("grindout")
	

func add_to_line(score):
	if score == -1:
		mult += 1
	else:
		scored_line += score
	ui.update_label_score(scored_line, mult)	

func end_line():
	ui._on_clean_tricks_text_timer_timeout()
	#save_score(scored_line, mult) #implementar guardado de linea
	scored_line = 0
	mult = 1


func _on_timer_timeout():
	trickeable = true

func _on_manual_timer_timeout():
	holding_manual = false

func play_grind():
	$Tricks/AnimationPlayerGrinds.play("nosegrind")
	ui.update_label_text("NOSEGRIND")
	add_to_line(-1) #el -1 indica que se añade un multiplicador

func stop_grind():
	$Tricks/AnimationPlayerGrinds.stop()

func is_grinding(grinding):
	isgrinding = grinding
