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
		$HUD/FinalScore.visible = false
		$HUD/Score.visible = true
		$HUD/AliensCount.visible = true
		$HUD/Angle.visible = true
		$HUD/Power.visible = true
		var _power = $Ball.get_power()
		var _angle = $Ball.get_angle()
		on_Power_update(_power)
		on_Angle_update(_angle)
	elif _aliens_left == 0:
		$HUD/FinalScore.visible = true
		$HUD/Score.visible = false
		$HUD/AliensCount.visible = false
		$HUD/Angle.visible = false
		$HUD/Power.visible = false
		$HUD/FinalScore.text = "GAME OVER\nFinal Score: " + str(_score)
	$HUD/AliensCount.text = "Aliens Left: " + str(_aliens_left)
	$HUD/Score.text = "Score: " + str(_score)
	if Input.is_action_just_pressed("restart"):
		restart()

func spawn_alien():
	var alien : RigidBody2D = load("res://src/Ball.tscn").instance()
	var _alien_connect = alien.connect("sleeping_state_changed", self, "on_alien_stop_movement")
	alien.position = Vector2(69, 350)
	call_deferred("add_child", alien)

func spawn_star():
	var star : Area2D = load("res://src/Star_Target.tscn").instance()
	var _star_connect = star.connect("body_entered", self, "_on_star_hit", [star])
	if _score == 0:
		star.position = Vector2(335, 393)
	elif _score == 1:
		star.position = Vector2(66, 56)
	elif _score == 2:
		star.position = Vector2(488, 222)
	elif _score == 3:
		star.position = Vector2(865, 157)
	elif _score == 4:
		star.position = Vector2(685, 348)
	call_deferred("add_child", star)
	_star_hit = false

func on_Power_update(new_power):
	$HUD/Power.text = "Power: %d" % int(new_power / 9) + "%"

func on_Angle_update(new_angle):
	$HUD/Angle.text = "Angle: " + str(int(-new_angle)) + "°"

	
func _on_star_hit(alien, star):
	$StarSound.play()
	if alien == $Ball:
		_star_hit = true
		call_deferred("remove_child", alien)
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

func on_alien_stop_movement():
	_sleep_counter += 1
	if _sleep_counter == 3:
		if _star_hit == false:
			if _aliens_left > 0:
				_aliens_left -= 1
				_delete_alien()

func restart():
	var _restart_game = get_tree().change_scene("res://src/Level.tscn")
