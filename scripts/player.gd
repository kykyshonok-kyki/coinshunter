extends CharacterBody3D


const SPEED = 5.0
const SPRINT = 9.0
const JUMP_VELOCITY = 4.5
const ROT_SPEED = 0.002

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity : float = ProjectSettings.get_setting("physics/3d/default_gravity")

# Movement vars
var rot_x : float = 0.0
var rot_y : float = 0.0

# Signals
signal set_state

func _init() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func earn_coin() -> void:
	print("Coin + 1")

func _physics_process(delta: float) -> void:
	var cur_state : String = ''
	var cur_anim : String = ''

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir : Vector2 = Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	var direction : Vector3 = $head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	direction.y = 0
	direction = direction.normalized()
	if direction:
		if Input.is_action_pressed("sprint") and velocity.y == 0:
			velocity.x = direction.x * SPRINT
			velocity.z = direction.z * SPRINT
		else:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# Update head direction
	$head.transform.basis = Basis(Vector3(0, 1, 0), rot_y) * Basis(Vector3(1, 0, 0), rot_x)

	emit_signal("set_state", cur_state, cur_anim)
	move_and_slide()

func _input(e: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

	# Head rotation
	if e is InputEventMouseMotion:
		rot_x -= e.relative.y * ROT_SPEED
		rot_y -= e.relative.x * ROT_SPEED
		if rot_x < -1:
			rot_x = -1
		if rot_x > 1.6:
			rot_x = 1.6
