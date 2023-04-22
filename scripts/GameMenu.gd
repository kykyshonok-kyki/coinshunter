extends Control

var cont_button: Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cont_button = $PanelContainer/VBoxContainer/ContinueButton

# Toggle game menu
func _close_and_open() -> void:
	visible = not visible
	get_tree().paused = not get_tree().paused
	if visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and not cont_button.button_pressed:
		_close_and_open()
		
func _on_continue_button_pressed() -> void:
	_close_and_open()

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_quit_button_pressed() -> void:
	Global.exit()
