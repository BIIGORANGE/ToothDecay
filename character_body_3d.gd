extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
@onready var camera_pitch: Node3D = $CameraPitch
@onready var camera: Camera3D = $CameraPitch/Camera3D
@onready var character_body_3d: CharacterBody3D = $"."

var sensitivity = 0.01

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
	
func _unhandled_input(event :InputEvent) -> void:
	if event is InputEventMouseButton:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif event.is_action_pressed("pause"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		#how does this work? Why am i tracking the relative pos of x to rotate y?
		#mouse pos x determines y rotation on the character
		#because InputEventMouseMotion stores a Vector2 (x for left and right, y for up and down)
		#in 3D, rotation along the y axis is a rotation clockwise(right) and counter(left)
		self.rotate_y(-event.relative.x * 0.005)
		#same here, but flip x for y and right and left for up and down
		camera.rotate_x(-event.relative.y * 0.005)

	camera.rotation.x = clamp(camera.rotation.x, -1.5, 1.5)
