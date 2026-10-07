extends StaticBody3D

@export var finish: bool = false
var finish_texture = ResourceLoader.load("res://Assets/finish.tres")
@onready var banner = $Banner
@onready var label = $Label3D

var startup = true

func _ready() -> void:
	if finish:
		label.text = ""
		banner.material_override = finish_texture
	else:
		label.text = "Checkpoint " + self.name


func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if not startup:
		activate_checkpoint()
		


func activate_checkpoint() -> void:
	Checkpoints.check_checkpoint(self)
	if finish:
		activate_finish()


func activate_finish() -> void:
	print("activate finish")
	Laptimer.start_lap()


func _on_startup_timeout() -> void:
	startup = false
