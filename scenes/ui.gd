extends Control

var minutes=0
var seconds=0
const Dseconds=30
const Dminutes=1
var score_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Reset_Timer()
	$FinalScoreLabel.visible = false
	$PressA.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Controlautoload.final_score != -1 and score_count < Controlautoload.final_score:
		score_count += 1000
		$Counter.play()
		if score_count > Controlautoload.final_score:
			score_count = Controlautoload.final_score
	$FinalScoreLabel.text = str(score_count)
	
	if score_count == Controlautoload.final_score:
		$PressA.visible = true
		
	if Input.is_action_just_pressed("ollie") and $PressA.is_visible_in_tree():
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
	if Input.is_action_pressed("LB"):
		$Buttons/Ollietrick.text = "OLLIE 360"
		$Buttons/Fliptrick.text = "VARIALHEEL"
		$Buttons/Shovetrick.text = "360 SHOVE-IT"
	
	if Input.is_action_pressed("RB"):
		$Buttons/Ollietrick.text = "BACKFLIP"
		$Buttons/Fliptrick.text = "360 FLIP"
		$Buttons/Shovetrick.text = "IMPOSSIBLE"
	
	if Input.is_action_just_released("RB") or Input.is_action_just_released("LB"):
		$Buttons/Ollietrick.text = "OLLIE"
		$Buttons/Fliptrick.text = "KICKFLIP"
		$Buttons/Shovetrick.text = "SHOVE-IT"
	
func Reset_Timer():
	seconds=Dseconds
	minutes=Dminutes


func _on_sec_timer_timeout():
	seconds-=1
	if seconds==0:
		if minutes > 0:
			minutes-=1
			seconds=60
	if seconds < 10:
		if minutes==0:
			$GameplayTimer.text="0" + str(minutes) + ":0" + str(seconds)
			$GameplayTimer.modulate = (Color(0.8, 0, 0, 1))
		else:
			$GameplayTimer.text="0" + str(minutes) + ":0" + str(seconds)
	else:
		$GameplayTimer.text="0" + str(minutes) + ":" + str(seconds)


func _on_total_timer_timeout():
	$GameplayTimer/SecTimer.stop()
	$Label.visible = false
	$Buttons.visible = false
	var skater = get_tree().get_nodes_in_group("player")
	skater[0].stop_player()
	$FinalScoreLabel.visible = true
	
	


