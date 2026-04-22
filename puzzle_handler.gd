extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(toggle_rotation(5))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func toggle_rotation(number_of_gears):
	#gear binary stack? A system that checks a bool val of the 
	#first object to determine the next?
	
	#recursively implemented a "flipping" system. takes as input any number and 
	#flips the sign that many times and outputs the final result as a 1 or -1
	if number_of_gears == 1:
		return 1

	return -1 * toggle_rotation(abs(number_of_gears) - 1)
	
	
