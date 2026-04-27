extends StaticBody3D

@onready var repair_timer: Timer = $RepairTimer
@onready var failure_timer: Timer = $FailureTimer
@onready var interact_range: Area3D = $InteractRange
@onready var mesh: MeshInstance3D = $MeshInstance3D
@onready var door_1: StaticBody3D = $"../Door_1"

var random_time = randf_range(10,40)
var gear_box_active = true
var opened = true

const REPAIRTIME = 2.5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	print(random_time)
	repair_timer.set_wait_time(REPAIRTIME)
	failure_timer.set_wait_time(random_time)
	failure_timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_interact_emitted() -> void:
	if !gear_box_active:
		print("failed to open door")
		repair_timer.start()
		print("starting repairs")
		failure_timer.set_wait_time(random_time)
	elif gear_box_active and !opened:
		opened = true
		door_1.position.y +=4
	elif gear_box_active and opened:
		opened = false
		door_1.position.y -=4

func _on_failure_timer_timeout() -> void:
	gear_box_active = false
	if !gear_box_active and opened:
		door_1.position.y -=4
	opened = false
	print("Gear Box failure")
	

func _on_repair_timer_timeout() -> void:
	repair_timer.stop()
	failure_timer.start()
	gear_box_active = true
	print("repairs complete")
	
