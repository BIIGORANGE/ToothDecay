extends OmniLight3D

var energy
@onready var flicker: Timer = $Flicker

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	flicker.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func light_flicker(energy):
	light_energy = energy
	
func _on_flicker_timeout() -> void:
	flicker.start()
	energy = randf_range(0.8,1)
	light_flicker(energy)
