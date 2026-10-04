extends MarginContainer

@onready var vehicle = get_parent()

@onready var speed = $speed
var speedometer_text = " kmh"


func _ready() -> void:
	set_speedometer(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_speedometer(vehicle.get_forward_speed())


func set_speedometer(speed_value: float) -> void:
	speed.text = str(snapped(speed_value * 3.6, 0.01)) + speedometer_text
	speed.show()
