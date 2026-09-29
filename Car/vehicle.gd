extends VehicleBody3D

const STEER_SPEED: float = 1.0
const STEER_LIMIT: float = 0.4
const BRAKE_STRENGTH: float = 300

@onready var driven_wheels = [$RR,$LR]
@onready var steering_wheels = [$FR,$FL]

@onready var cams = [$cockpit,$closechase,$farchase,$TESTCAM]
var current_cam = 0
var cam_transition_speed: float = 2.5

var steer_target: float = 0.0
var ENGINE_POWER: float = 20000.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for wheel in driven_wheels:
		wheel.use_as_traction = true
	for wheel in steering_wheels:
		wheel.use_as_steering = true
		wheel.use_as_traction = true
	$Camera.transform = cams[current_cam].transform


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("accelerate"):
		engine_force = ENGINE_POWER
	elif Input.is_action_pressed("reverse") and not is_moving_forwards():
		engine_force = -ENGINE_POWER * 0.5
	else:
		engine_force = 0
		
	if Input.is_action_pressed("brake"):
		brake = BRAKE_STRENGTH
	else:
		brake = 0
	
	if Input.is_action_just_pressed("camera"):
		current_cam = (current_cam + 1) % len(cams)
	change_cam(delta)
	
	
func change_cam(delta) -> void:
	var weight = 1 - exp(-cam_transition_speed * delta)
	$Camera.transform = $Camera.transform.interpolate_with(cams[current_cam].transform, weight)


func is_moving_forwards() -> bool:
	var forward_vec = global_transform.basis.z #Forward vector is +z
	var forward_speed = linear_velocity.dot(forward_vec) #How much velocity is in forward direction?
	return forward_speed > 0.5
