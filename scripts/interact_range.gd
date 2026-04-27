extends Area3D

var is_in_range := false
signal interact
@onready var prompt: Label = $Prompt
@export var prompt_message = "Interact"
@export var prompt_action = "interact"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	prompt.hide()
	if Input.is_action_just_pressed("interact") and is_in_range:
		emit_signal("interact")
	get_prompt()

func _on_body_entered(body: CharacterBody3D) -> void:
	is_in_range = true

func _on_body_exited(body: CharacterBody3D) -> void:
	is_in_range = false
	
func get_prompt():
	var key_name = ""
	if is_in_range:
		prompt.show()
		prompt.text = "Press E to use " + str(get_parent().name)
	

	
