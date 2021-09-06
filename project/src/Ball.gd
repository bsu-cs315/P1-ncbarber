extends RigidBody2D

var _angle = 0
export var degrees_per_second = 20
export var power = 200
export var speed = 100

func _process(delta):
	if Input.is_action_just_pressed("launch"):
		var impulse = Vector2.RIGHT.rotated(deg2rad(_angle)) * 250
		apply_impulse(Vector2.ZERO, impulse)
	if Input.is_action_pressed("increase angle"):
		_angle -= degrees_per_second * delta
		print(_angle)
	if Input.is_action_pressed("decrease angle"):
		_angle += degrees_per_second * delta
		print(_angle)
	if Input.is_action_pressed("increase power"):
		speed += power* delta
	if Input.is_action_pressed("decrease power"):
		speed -= power * delta
