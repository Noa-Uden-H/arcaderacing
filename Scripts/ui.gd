extends Control

@onready var vehicle = get_parent()
@onready var needle = $needle

var target_needle_angle = 0.0


func _ready() -> void:
	needle.rotation = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var speed_kmh = vehicle.get_forward_speed() * 3.6
	target_needle_angle = deg_to_rad(speed_kmh * 360/400)
	needle.rotation = lerp_angle(needle.rotation,target_needle_angle,20*delta)
