extends Node
signal checkpoint_activated
signal finish_lap_relay

@onready var checkpoints = $"/root/Main/track/Checkpoints".get_children()
@onready var finish = checkpoints[0]
@onready var current_checkpoint = finish
var current_checkpoint_index = 0
var next_checkpoint = 0


func check_checkpoint(checkpoint: StaticBody3D) -> bool:
	if checkpoints[next_checkpoint] == checkpoint:
		increment_checkpoints()
		checkpoint_activated.emit()
		return true
	return false


func increment_checkpoints() -> void:
	current_checkpoint = checkpoints[next_checkpoint]
	current_checkpoint_index = next_checkpoint
	next_checkpoint = (next_checkpoint + 1) % len(checkpoints)


func reset_checkpoints() -> void:
	current_checkpoint = finish
	current_checkpoint_index = 0
	next_checkpoint = 0
	checkpoint_activated.emit()


func relay_finish_signal() -> void:
	finish_lap_relay.emit()
