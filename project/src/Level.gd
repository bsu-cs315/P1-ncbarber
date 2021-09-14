extends Node2D

var _aliens_left = 5
var _score = 0

func _process(_delta):
	if _aliens_left > 0:
		var _power = $Ball.get_power()
		var _angle = $Ball.get_angle()
		#on_Power_update(_power)
		on_Angle_update(_angle)
	$HUD/AliensCount.text = "Aliens Left: " + str(_aliens_left)
	$HUD/Score.text = "Score: " + str(_score)
	if Input.is_action_just_pressed("restart"):
		restart()


#func on_Power_update(new_power):
	

func on_Angle_update(new_angle):
	$HUD/Angle.text = "Angle: " + str(int(-new_angle)) + "°"

func _on_Star_Target_entered(_body):
	print("Hit!")

func restart():
	var _restart_game = get_tree().change_scene("res://src/Level.tscn")
