extends Node
@onready var vehicle_scene: PackedScene = preload("res://Car/bus.tscn")
@onready var vehicle_ref = $"/root/Main/VehicleBody3D"


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("reset") and (vehicle_ref.linear_velocity.length_squared() <= 0.05):
		respawn_vehicle(vehicle_ref)
	if event.is_action_pressed("respawn"):
		respawn_vehicle(Checkpoints.current_checkpoint)
	if event.is_action_pressed("restart"):
		respawn_vehicle(Checkpoints.finish)
		Checkpoints.reset_checkpoints()
		Laptimer.laptime = 0
		Laptimer.lap_started = false


func respawn_vehicle(respawn_obj) -> void:
	var pos = respawn_obj.global_position if respawn_obj == vehicle_ref else respawn_obj.get_node("spawn_marker").global_position
	var rot = respawn_obj.global_rotation.y if respawn_obj == vehicle_ref else respawn_obj.get_node("spawn_marker").global_rotation.y	
	var cam = vehicle_ref.current_cam
	vehicle_ref.queue_free()
	
	var new_vehicle = vehicle_scene.instantiate()
	$"/root/Main".add_child(new_vehicle)
	vehicle_ref = new_vehicle
	new_vehicle.global_position = pos
	new_vehicle.global_rotation.y = rot
	new_vehicle.current_cam = cam
