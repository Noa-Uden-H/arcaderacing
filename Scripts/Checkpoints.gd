extends Node
signal checkpoint_activated


@onready var checkpoints = $"/root/Main/track/Checkpoints".get_children()
@onready var finish = checkpoints[0]
var current_checkpoint = finish
var next_checkpoint = 0


func _ready() -> void:
	pass


func check_checkpoint(checkpoint: StaticBody3D) -> bool:
	if checkpoints[next_checkpoint] == checkpoint:
		checkpoint_activated.emit()
		increment_checkpoints()
		#print(next_checkpoint)
		return true
	return false


func increment_checkpoints() -> void:
	current_checkpoint = checkpoints[next_checkpoint]
	next_checkpoint = (next_checkpoint + 1) % len(checkpoints)
