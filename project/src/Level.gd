extends Node2D


func _process(_delta):
	
	if Input.is_action_just_pressed("restart"):
		restart()

func _on_Star_Target_entered(_body):
	print("Hit!")

func restart():
	var _restart_game = get_tree().change_scene("res://src/Level.tscn")
