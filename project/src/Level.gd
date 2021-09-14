extends Node2D

var _aliens_left = 5
var _score = 0
var _sleep_counter = 0
var _star_hit = false

func _ready():
	spawn_alien()
	spawn_star()

func _process(_delta):
	if _aliens_left > 0:
		var _power = $Ball.get_power()
		var _angle = $Ball.get_angle()
		on_Power_update(_power)
		on_Angle_update(_angle)
	$HUD/AliensCount.text = "Aliens Left: " + str(_aliens_left)
	$HUD/Score.text = "Score: " + str(_score)
	if Input.is_action_just_pressed("restart"):
		restart()

func spawn_alien():
	var alien : RigidBody2D = load("res://src/Ball.tscn").instance()
	#var _alien_connect = alien.connect("sleeping_state_changed", self, "on_alien_stop_movement")
	alien.position = Vector2(69, 350)
	call_deferred("add_child", alien)

func spawn_star():
	var star : Area2D = load("res://src/Star_Target.tscn").instance()
	var _star_connect = star.connect("body_entered", self, "_on_star_hit", [star])
	if _score == 0:
		star.position = Vector2(865, 157)
	if _score == 1:
		star.position = Vector2(335, 393)
	call_deferred("add_child", star)
	_star_hit = false

func on_Power_update(new_power):
	$HUD/Power.text = "Power: %d" % int(new_power / 9) + "%"

func on_Angle_update(new_angle):
	$HUD/Angle.text = "Angle: " + str(int(-new_angle)) + "°"

func _on_Star_Target_entered(_body):
	print("Hit!")
	
		
func _on_star_hit(body, star):
	print("hit")
	if body == $Ball:
		_star_hit = true
		call_deferred("remove_child", body)
		call_deferred("remove_child", star)
		_aliens_left -= 1
		_score += 1
		_sleep_counter = 0
		if _aliens_left > 0:
			spawn_alien()
			spawn_star()

func _delete_alien():
	var _alien = $Ball.get_ball()
	call_deferred("remove_child", _alien)
	spawn_alien()
	_sleep_counter = 0

#func on_alien_stop_movement():
#	_sleep_counter += 1
#	if _sleep_counter == 4:
#		if _star_hit == false:
#			if _aliens_left > 0:
#				_aliens_left -= 1
#				_delete_alien()

func restart():
	var _restart_game = get_tree().change_scene("res://src/Level.tscn")
