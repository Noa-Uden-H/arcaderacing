extends StaticBody3D

@export var finish: bool = false
var finish_texture = ResourceLoader.load("res://Assets/finish.tres")
@onready var banner = $Banner
@onready var label = $Label3D

func _ready() -> void:
	if finish:
		label.text = ""
		banner.material_override = finish_texture
	else:
		label.text = self.name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
