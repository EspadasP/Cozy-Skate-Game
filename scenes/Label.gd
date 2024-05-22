extends Label

var timer_can_start = true

# Function to update the label text
func update_label_text(new_text: String):
	if text.length() < 1:
		text = new_text
	else:
		text += " + " + new_text

func update_label_score(score, mult):
	$Scorelabel.text = str(score)
	$MultLabel.text = "x " + str(mult)
	


# implementar de manera que se haga un clear del texto al tocar el suelo pero no estar en manual o grind
func clear_label_text(): 
	if timer_can_start:
		$CleanTricksTextTimer.start()
		timer_can_start = false

func current_score_update(linescore):
	$CurrentScoreLabel.text = str(linescore)



	


func _on_clean_tricks_text_timer_timeout():
	text = ""
	$Scorelabel.text = ""
	$MultLabel.text = ""
	timer_can_start = true
