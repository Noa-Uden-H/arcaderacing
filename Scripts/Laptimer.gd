extends Node

var laptime = 0
var lap_started = false


func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if lap_started:
		laptime += delta
	

func start_lap() -> void:
	laptime = 0
	lap_started = true
	

func save_laptime(previous_laptime) -> void:
	var save_file = FileAccess.open("user://laptimes.save", FileAccess.WRITE)
	var time_data_json = JSON.stringify(previous_laptime)
	save_file.store_line(time_data_json)
