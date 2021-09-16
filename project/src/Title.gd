extends Control

func _on_Button_pressed():
	var _ignored := get_tree().change_scene("res://src/Level.tscn")


func _on_Intro_animation_finished(_anim_name):
	$GameLabel/Intro.play("IntroRotate")
