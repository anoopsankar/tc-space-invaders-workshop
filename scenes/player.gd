extends CharacterBody2D

var speed := 250
var hp := 5

signal fire_laser(pos: Vector2)
signal hp_down(amt: int)
signal player_killed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	var direction = Input.get_vector("left", "right","up","down")
	velocity = direction * speed
	
	move_and_slide()
	
	if Input.is_action_just_pressed("fire"):
		fire_laser.emit(position)

func _take_damage() -> void:
	
	hp = hp - 1
	hp_down.emit(hp)
	
	if hp == 0:
		player_killed.emit()
		queue_free()
	
