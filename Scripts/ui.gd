extends Control

@onready var vehicle = get_parent()
@onready var needle = $Speedometer/needle
@onready var laptimer = $Times/VBoxContainer/Laptime

var laptime = 0
var lap_started = false

var target_needle_angle = 0.0


func _ready() -> void:
	needle.rotation = 0
	start_lap()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var speed_kmh = vehicle.get_forward_speed() * 3.6
	target_needle_angle = deg_to_rad(abs(speed_kmh) * 360/400)
	needle.rotation = lerp_angle(needle.rotation,target_needle_angle,20*delta)
	
	#Laptime
	if lap_started:
		laptime += delta
		var minutes = floor(laptime / 60)
		var seconds = int(fmod(laptime,60))
		var mseconds = int(fmod(laptime, 1) * 100)
		var timer = "%02d:%02d:%02d" % [minutes, seconds, mseconds]
	
		laptimer.text = timer
		laptimer.show()
	
func start_lap() -> void:
	laptime = 0
	lap_started = true
	
