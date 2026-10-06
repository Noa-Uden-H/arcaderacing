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
		laptimer.text = timefloat_to_timestring(laptime)
		laptimer.show()
	
	
func start_lap() -> void:
	laptime = 0
	lap_started = true
	

func save_laptime(laptime) -> void:
	var save_file = FileAccess.open("user://laptimes.save", FileAccess.WRITE)
	var time_data_json = JSON.stringify(laptime)
	save_file.store_line(time_data_json)
	
	
func timefloat_to_timestring(time: float) -> String:
	var minutes = floor(time/ 60)
	var seconds = int(fmod(time,60))
	var mseconds = int(fmod(time, 1) * 100)
	var timer = "%02d:%02d:%02d" % [minutes, seconds, mseconds]
	return timer
