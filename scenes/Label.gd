extends Label


# Function to update the label text
func update_label_text(new_text: String):
	if text.length() < 1:
		text = new_text
	else:
		text += " + " + new_text


# implementar de manera que se haga un clear del texto al tocar el suelo pero no estar en manual o grind
func clear_label_text(): 
	$CleanTricksTextTimer.start()
	


func _on_clean_tricks_text_timer_timeout():
	text = ""
