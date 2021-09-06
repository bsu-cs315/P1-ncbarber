extends RigidBody2D

var _angle = 0
export var degrees_per_second = 20
export var power = 200
export var exit_speed = 0

func _process(delta):
	if Input.is_action_just_pressed("launch"):
		var exit_angle = Vector2.RIGHT.rotated(deg2rad(_angle))
		var impulse = exit_angle * exit_speed
		apply_impulse(Vector2.ZERO, impulse)
		$ArrowRotation.visible = false
	if Input.is_action_pressed("increase angle"):
		_angle -= degrees_per_second * delta
		_angle = clamp(_angle, -90, 0)
		#print(_angle)
		update_arrow_angle(_angle)
	if Input.is_action_pressed("decrease angle"):
		_angle += degrees_per_second * delta
		_angle = clamp(_angle, -90, 0)
		#print(_angle)
		update_arrow_angle(_angle)
	if Input.is_action_pressed("increase power"):
		exit_speed += power* delta
		exit_speed = clamp(exit_speed, 0, 900)
		print(exit_speed)
	if Input.is_action_pressed("decrease power"):
		exit_speed -= power * delta
		exit_speed = clamp(exit_speed, 0, 900)
		print(exit_speed)

func update_arrow_angle(exit_angle):
	$ArrowRotation.rotation_degrees = exit_angle
