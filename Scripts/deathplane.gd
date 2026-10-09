extends Area3D


func _on_body_entered(body: Node3D) -> void:
	Respawns.respawn_vehicle(Checkpoints.current_checkpoint)
	if Checkpoints.current_checkpoint.finish:
			Laptimer.reset_timer()
