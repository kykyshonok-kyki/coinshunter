extends Area3D

# Constants
const ROT_SPEED: float = 0.3
const MOVE_SPEED: float = 0.2
const MAX_HEIGHT: float = 0.4

# Y positions
var bot_pos: float
var top_pos: float

# Bool
var is_moving_up: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bot_pos = position.y
	top_pos = bot_pos + MAX_HEIGHT

func _physics_process(delta: float) -> void:
	rotate_y(delta * ROT_SPEED)
	# Move in vertical
	var dist: float = delta * MOVE_SPEED
	if is_moving_up:
		if position.y + dist >= top_pos:
			position.y = top_pos - (dist - (top_pos - position.y))
			is_moving_up = false
		else:
			position.y += dist
	else:
		if position.y - dist <= bot_pos:
			position.y = bot_pos + (dist - (position.y - bot_pos))
			is_moving_up = true
		else:
			position.y -= dist


func _on_body_entered(body: Node3D) -> void:
	body.earn_coin()
	queue_free()
