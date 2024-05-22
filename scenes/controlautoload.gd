extends Node

var current_score = 0
var final_score = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	#save_game()
	#var data = load_game()
	#print(data)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func scored_line_add(score):
	current_score += score

func define_final_score():
	final_score = current_score
	print(final_score)
	#save_game()

#func save():
	#var save_dict = {
		#"score" : 0
	#}
	#return save_dict
	#
#func save_game():
	#var save_game = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	#var json_string = JSON.stringify(save())
#
#func load_game():
	#var node_data = null
	#if not FileAccess.file_exists("user://savegame.save"):
		#return
	#var save_game = FileAccess.open("user://savegame.save", FileAccess.READ)
	#
	#while save_game.get_position() < save_game().get_lenght():
		#var json_string = save_game.get_line()
		#var json = JSON.new()
		#var parse_result = json.parse(json_string)
		#node_data = json.get_data()
	#
	#return node_data
