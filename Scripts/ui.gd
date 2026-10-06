extends Control

@onready var vehicle = get_parent()
@onready var needle = $Speedometer/needle
@onready var laptimer = $Times/VBoxContainer/Laptime

var target_needle_angle = 0.0


func _ready() -> void:
	needle.rotation = 0
	Laptimer.start_lap()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var speed_kmh = vehicle.get_forward_speed() * 3.6
	target_needle_angle = deg_to_rad(abs(speed_kmh) * 0.9) #360 deg/400 kmh
	needle.rotation = lerp_angle(needle.rotation,target_needle_angle,20*delta)
	
	#Laptime	
	laptimer.text = timefloat_to_timestring(Laptimer.laptime)
	laptimer.show()
	
	
func timefloat_to_timestring(time: float) -> String:
	var minutes = floor(time/ 60)
	var seconds = int(fmod(time,60))
	var mseconds = int(fmod(time, 1) * 100)
	var timer = "%02d:%02d:%02d" % [minutes, seconds, mseconds]
	return timer
