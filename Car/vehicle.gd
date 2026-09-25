extends VehicleBody3D

const STEER_SPEED: float = 1.0
const STEER_LIMIT: float = 0.4
const BRAKE_STRENGTH: float = 0.5

var driven_wheels = [$RR,$LR]
var steering_wheels = [$FR,$FL]

var steer_target: float = 0.0
var engine_power: float = 40.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for wheel in driven_wheels:
		wheel.use_as_traction = true
	for wheel in steering_wheels:
		wheel.use_as_steering = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	pass
