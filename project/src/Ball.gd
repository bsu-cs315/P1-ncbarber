extends RigidBody2D

signal angle_changed(new_angle)
signal power_changed(new_power)

var _angle = 0
export var degrees_per_second = 20
export var _power = 200
export var _exit_speed = 0
var _is_launched = false

func _process(delta):
	#When spacebar hit, we launch the alien, play a sound and make the arrow element go invisible
	if Input.is_action_just_pressed("launch"):
		if _is_launched == false:
			var exit_angle = Vector2.RIGHT.rotated(deg2rad(_angle))
			var impulse = exit_angle * _exit_speed
			apply_impulse(Vector2.ZERO, impulse)
			$ArrowRotation.visible = false
			$LaunchSound.play()
			_is_launched = true
		
		
	#When we hit up or W we make the angle increase, and update the animation, and send out the value
	if Input.is_action_pressed("increase angle"):
		if _is_launched == false:
			_angle -= degrees_per_second * delta
			_angle = clamp(_angle, -90, 0)
			emit_signal("angle_changed", _angle)
			update_arrow_angle(_angle)
		
	#When we hit down or S we make the angle decrease, and update the animation, and send out the value
	if Input.is_action_pressed("decrease angle"):
		if _is_launched == false:
			_angle += degrees_per_second * delta
			_angle = clamp(_angle, -90, 0)
			emit_signal("angle_changed", _angle)
			update_arrow_angle(_angle)
		
	#When we hit right or D we make the power increase, and send out the value
	if Input.is_action_pressed("increase power"):
		if _is_launched == false:
			_exit_speed += _power* delta
			_exit_speed = clamp(_exit_speed, 1, 900)
			emit_signal("power_changed", _power)
		
	#When we hit left or A we make the power decrease, and send out the value
	if Input.is_action_pressed("decrease power"):
		if _is_launched == false:
			_exit_speed -= _power * delta
			_exit_speed = clamp(_exit_speed, 1, 900)
			emit_signal("power_changed", _power)
		
		
func get_power():
	return _exit_speed
	
func get_angle():
	return _angle

func get_ball():
	return self

#This is for the animation of the arrow
func update_arrow_angle(exit_angle):
	$ArrowRotation.rotation_degrees = exit_angle
