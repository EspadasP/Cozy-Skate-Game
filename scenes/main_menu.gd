extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("shove_trick") and $AudioSliders.is_visible_in_tree():
		$AudioSliders.visible = false
		$PlayButton.grab_focus()


	

func _on_quit_button_pressed():
	get_tree().quit()


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/gameplay.tscn")


func _on_options_button_pressed():
	if $AudioSliders.is_visible_in_tree():
		$AudioSliders.visible = false
	else:
		$AudioSliders.visible = true
		$AudioSliders/Mastertag/Master.grab_focus()

