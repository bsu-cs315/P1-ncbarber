extends RigidBody2D

var _angle = 0
export var degrees_per_second = 20
export var power = 200
export var exit_speed = 100

func _process(delta):
	if Input.is_action_just_pressed("launch"):
		var exit_angle = Vector2.RIGHT.rotated(deg2rad(_angle))
		var impulse = exit_angle * exit_speed
		apply_impulse(Vector2.ZERO, impulse)
	if Input.is_action_pressed("increase angle"):
		_angle -= degrees_per_second * delta
		print(_angle)
	if Input.is_action_pressed("decrease angle"):
		_angle += degrees_per_second * delta
		print(_angle)
	if Input.is_action_pressed("increase power"):
		exit_speed += power* delta
		print(exit_speed)
	if Input.is_action_pressed("decrease power"):
		exit_speed -= power * delta
		print(exit_speed)
