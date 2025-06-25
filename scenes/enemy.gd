extends Area2D

signal enemy_killed(pos: Vector2)
signal ship_hit

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += 150 * delta


func _on_area_entered(area: Area2D) -> void:
	enemy_killed.emit(position)

	area.queue_free()
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	ship_hit.emit()
	
	enemy_killed.emit(position)
	queue_free()
