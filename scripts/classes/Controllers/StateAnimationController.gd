@tool
class_name StateAnimationController
extends Controller

@export var state : String = '' :
	set(new_state):
		state = new_state
		update_configuration_warnings()

@export var anim_player : AnimationPlayer = null :
	set(new_anim_player):
		anim_player = new_anim_player
		update_configuration_warnings()

func _ready() -> void:
	get_parent().connect("set_state", Callable(self, "_on_set_state"))

func _on_set_state(s : String, a : String = '') -> void:
	if s == state: return
	state = s
	if a == '' || anim_player.current_animation == a: return
	anim_player.play("RESET")
	anim_player.play(a)

func _get_configuration_warnings() -> PackedStringArray:
	var warnings : PackedStringArray = PackedStringArray()
	if state == '':
		warnings.append("A state value must be provided for StateAnimationController. Please write the name of the default state in the Inspector.")
	if anim_player == null:
		warnings.append("An animation player must be provided for StateAnimationController to function. Please specify it in the Inspector.")
	return warnings
