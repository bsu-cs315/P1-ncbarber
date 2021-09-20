extends Node2D

var _aliens_left = 5
var _score = 0
var _sleep_counter = 0
var _is_star_hit = false

# On start spawn in the Alien and Star
func _ready():
	$HUD/FinalScore.visible = false
	$HUD/Score.visible = false
	$HUD/AliensCount.visible = false
	$HUD/Angle.visible = false
	$HUD/Power.visible = false
	spawn_alien()
	spawn_star()
	
func _process(_delta):
	# Every Frame looking for if the amount of aliens launched is at 0
	# If it is greater than 0 then it will watch to update the HUD
	if _aliens_left > 0:
		$HUD/FinalScore.visible = false
		$HUD/Score.visible = true
		$HUD/AliensCount.visible = true
		$HUD/Angle.visible = true
		$HUD/Power.visible = true
		$HUD/Replay.visible = false
		var _power = $Ball.get_power()
		var _angle = $Ball.get_angle()
		on_Power_update(_power)
		on_Angle_update(_angle)
	# If there are no more aliens left it will show the game over screen
	elif _aliens_left == 0:
		$HUD/FinalScore.visible = true
		$HUD/Score.visible = false
		$HUD/AliensCount.visible = false
		$HUD/Angle.visible = false
		$HUD/Power.visible = false
		$HUD/FinalScore.text = "GAME OVER\nFinal Score: " + str(_score)
		$HUD/Replay.visible = true

	$HUD/AliensCount.text = "Aliens Left: " + str(_aliens_left)
	$HUD/Score.text = "Score: " + str(_score)
	# Simple Restart Button "R"
	if Input.is_action_just_pressed("restart"):
		restart()


# When this is called it loads an instance of the Alien at the launch position
# This also connects the sleeping_state_changed to my function for when the sleeping state is changed
func spawn_alien():
	var alien : RigidBody2D = load("res://src/Ball.tscn").instance()
	var _alien_connect = alien.connect("sleeping_state_changed", self, "on_alien_stop_movement")
	alien.position = Vector2(69, 350)
	call_deferred("add_child", alien)


# When called, spawns in the star based on how many starts have been collected
# This also connects some functions so that each star will trigger when it is hit
func spawn_star():
	var star : Area2D = load("res://src/Star_Target.tscn").instance()
	var _star_connect = star.connect("body_entered", self, "_on_star_hit", [star])
	# Spawns star at different positions if they have been collected
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
	_is_star_hit = false


# Basic updates for the HUD for Power and Angle
func on_Power_update(new_power):
	$HUD/Power.text = "Power: %d" % int(new_power / 9) + "%"


func on_Angle_update(new_angle):
	$HUD/Angle.text = "Angle: " + str(int(-new_angle)) + "°"


# When the star is hit we check it was the alien, then we can do all the changes we need to.
# The amount of aliens goes down, score goes up, and we despawn and respawn a new alien and star
func _on_star_hit(alien, star):
	$StarSound.play()
	if alien == $Ball:
		_is_star_hit = true
		call_deferred("remove_child", alien)
		call_deferred("remove_child", star)
		_aliens_left -= 1
		_score += 1
		_sleep_counter = 0
		if _aliens_left > 0:
			spawn_alien()
			spawn_star()


# Here we despawn and respawn a new alien
func _delete_alien():
	# Here we get the specific item that was launched, this helped in fixing issues of multiple aliens being spawned
	var _alien = $Ball.get_ball()
	call_deferred("remove_child", _alien)
	spawn_alien()
	_sleep_counter = 0


# This counts whenever the sleep state is changed of an alien, so that it is deleted after 
# there are no forces acting upon it
func on_alien_stop_movement():
	_sleep_counter += 1
	if _sleep_counter == 3:
		if _is_star_hit == false:
			if _aliens_left > 0:
				_aliens_left -= 1
				_delete_alien()


func restart():
	var _restart_game = get_tree().change_scene("res://src/Title.tscn")
	


func _on_Replay_pressed():
	var _restart_game = get_tree().change_scene("res://src/Title.tscn")
