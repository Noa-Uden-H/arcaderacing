extends VehicleBody3D

const STEER_SPEED: float = 0.8
const STEER_LIMIT: float = 0.25
const BRAKE_STRENGTH: float = 350

@onready var driven_wheels = [$RR,$LR]
@onready var steering_wheels = [$FR,$FL]

@onready var cams = [$cockpit,$closechase,$farchase,$reversecam]
var current_cam = 0
var cam_before_reverse = 0
var cam_transition_speed: float = 2.5
var moving_backwards

var steer_target: float = 0.0
var ENGINE_POWER: float = 25000.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for wheel in driven_wheels:
		wheel.use_as_traction = true
	for wheel in steering_wheels:
		wheel.use_as_steering = true
		wheel.use_as_traction = true
	$Camera.transform = cams[current_cam].transform


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("camera") and not moving_backwards:
		current_cam = (current_cam + 1) % (len(cams) - 1)
		cam_before_reverse = current_cam

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#Forward and backward acceleration
	if Input.is_action_pressed("accelerate"):
		engine_force = ENGINE_POWER
	elif Input.is_action_pressed("reverse") and not is_moving_forwards():
		engine_force = -ENGINE_POWER * 0.5
	else:
		engine_force = 0
		
	#Braking
	if Input.is_action_pressed("brake"):
		brake = BRAKE_STRENGTH
	else:
		brake = 0
	
	#Steering
	if Input.is_action_pressed("left"):
		steer_target = 1
	elif Input.is_action_pressed("right"):
		steer_target = -1
	else:
		steer_target = 0
	
	steering = move_toward(steering, steer_target*STEER_LIMIT, STEER_SPEED * delta)
	
	#Reversecam
	reverse_cam()
	
	#Camera
	change_cam(delta)
	
	#Debug if below platform
	if global_position.y < -1:
		print("off")
	
	
func change_cam(delta) -> void:
	var weight = 1 - exp(-cam_transition_speed * delta)
	$Camera.transform = $Camera.transform.interpolate_with(cams[current_cam].transform, weight)


func reset_vehicle() -> void:
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
	rotation.x = 0
	rotation.z = 0
	global_position.y += 2


func is_moving_forwards() -> bool:
	var forward_speed = get_forward_speed()
	return forward_speed > 0.5


func get_forward_speed() -> float:
	var forward_vec = global_transform.basis.z #Forward vector is +z
	var forward_speed = linear_velocity.dot(forward_vec) #How much velocity is in forward direction?
	return forward_speed


func reverse_cam() -> void:
	if get_forward_speed() < -1:
		moving_backwards = false
		current_cam = len(cams) - 1
		return
	if get_forward_speed() > 2:
		current_cam = cam_before_reverse
		moving_backwards = true
