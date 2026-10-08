extends Control

@onready var vehicle = get_parent()
@onready var needle = $Speedometer/needle
@onready var laptimer = $Times/VBoxContainer/Laptime

var target_needle_angle = 0.0


func _ready() -> void:
	needle.rotation = 0
	Checkpoints.checkpoint_activated.connect(update_checkpoint_counter)
	Checkpoints.finish_lap_relay.connect(display_laps)
	update_checkpoint_counter()
	display_laps()


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


func update_checkpoint_counter() -> void:
	$Checkpoints/CheckpointCounter.text = str(Checkpoints.current_checkpoint_index) + "/" + str(len(Checkpoints.checkpoints) - 1)


func display_laps() -> void:
	var laptimes_label = $Times/VBoxContainer/Laptimes
	laptimes_label.text = "Previous laps:\n"
	for lap in Laptimer.previous_laps:
		laptimes_label.text += timefloat_to_timestring(lap) + '\n'
	laptimes_label.show()
