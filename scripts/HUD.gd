extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.score_lable = $ScoreLable
	Global.score = 0
