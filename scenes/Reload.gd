extends Control

var skater = null

# Called when the node enters the scene tree for the first time.
func _ready():
	skater = get_tree().get_nodes_in_group("player")
	

func _on_timer_timeout():
	$ProgressBar.value+=2.5
	$TextureProgressBar.value+=2.5

func _on_reload_timeout():
	$ProgressBar.value=0
	$TextureProgressBar.value=0
	$Timer.stop()
	
