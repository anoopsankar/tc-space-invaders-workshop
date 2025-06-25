extends Node2D

var score := 0

var enemy_scene:PackedScene = load("res://scenes/enemy.tscn")
var explosion_scene:PackedScene = load("res://scenes/explosion.tscn")
var laser_scene:PackedScene = load("res://scenes/laser.tscn")

func _on_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	add_child(enemy)
	
	var rx = randf_range(0, get_viewport_rect().size.x)
	enemy.position = Vector2(rx, 10)
	
	enemy.connect("enemy_killed", _on_enemy_killed)
	enemy.connect("ship_hit", _on_ship_hit)

func _on_enemy_killed(pos) -> void:
	score += 100
	$ScoreLabel.text = str(score).pad_zeros(5)
	var explosion = explosion_scene.instantiate()
	add_child(explosion)
	explosion.position = pos
	
func _on_ship_hit() -> void:
	$Player._take_damage()

func _on_player_fire_laser(pos: Vector2) -> void:
	var laser = laser_scene.instantiate()
	add_child(laser)
	
	$LaserShotSFX.play()
	
	laser.position = pos

func _on_player_hp_down(amt: int) -> void:
	$Health.text = str(amt)

func _on_player_player_killed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_over.tscn")
