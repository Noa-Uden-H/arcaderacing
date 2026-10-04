extends Control

@onready var vehicle = get_parent()
@onready var speed = $speed
@onready var needle = $needle

var speedometer_text = " kmh"
var target_needle_angle = 0.0


func _ready() -> void:
	set_speedometer(0)
	needle.rotation = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var speed_kmh = vehicle.get_forward_speed() * 3.6
	target_needle_angle = deg_to_rad(speed_kmh * 360/400)
	needle.rotation = lerp_angle(needle.rotation,target_needle_angle,20*delta)

	set_speedometer(speed_kmh)


func set_speedometer(speed_value: float) -> void:
	speed.text = str(snapped(speed_value, 0.01)) + speedometer_text
	speed.show()
