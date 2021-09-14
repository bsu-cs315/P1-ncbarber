extends RigidBody2D

signal angle_changed(new_angle)
signal power_changed(new_power)

var _angle = 0
export var degrees_per_second = 20
export var _power = 200
export var _exit_speed = 0

func _process(delta):
	if Input.is_action_just_pressed("launch"):
		var exit_angle = Vector2.RIGHT.rotated(deg2rad(_angle))
		var impulse = exit_angle * _exit_speed
		apply_impulse(Vector2.ZERO, impulse)
		$ArrowRotation.visible = false
		
		
	if Input.is_action_pressed("increase angle"):
		_angle -= degrees_per_second * delta
		_angle = clamp(_angle, -90, 0)
		emit_signal("angle_changed", _angle)
		update_arrow_angle(_angle)
		
		
	if Input.is_action_pressed("decrease angle"):
		_angle += degrees_per_second * delta
		_angle = clamp(_angle, -90, 0)
		emit_signal("angle_changed", _angle)
		update_arrow_angle(_angle)
		
		
	if Input.is_action_pressed("increase power"):
		_exit_speed += _power* delta
		_exit_speed = clamp(_exit_speed, 0, 900)
		emit_signal("power_changed", _power)
		#update_arrow_power(_exit_speed)
		
		
	if Input.is_action_pressed("decrease power"):
		_exit_speed -= _power * delta
		_exit_speed = clamp(_exit_speed, 0, 900)
		emit_signal("power_changed", _power)
		#update_arrow_power(_exit_speed)
		
		
func get_power():
	return _exit_speed
	
func get_angle():
	return _angle

func update_arrow_angle(exit_angle):
	$ArrowRotation.rotation_degrees = exit_angle

func update_arrow_power(speed):
	$ArrowRotation/Arrow.offset.x = speed * 0.1
