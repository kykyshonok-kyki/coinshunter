extends Node

var score: int = 0
var score_lable: Label

func take_coin() -> void:
	score += 1
	score_lable.text = 'Coins: ' + str(score)

func exit() -> void:
	get_tree().quit()
