extends RigidBody2D

var angle = 0

func _process(delta):
	if Input.is_action_just_pressed("launch"):
		var impulse = Vector2.RIGHT.rotated(deg2rad(angle)) * 250
		apply_impulse(Vector2.ZERO, impulse)
	if Input.is_action_pressed("increase angle"):
		angle -= 20 * delta
		print(angle)
