extends RigidBody2D

var angle = -45
var impulse = Vector2.RIGHT.rotated(deg2rad(angle)) * 250

func _process(_delta):
	if Input.is_action_just_pressed("launch"):
		apply_impulse(Vector2.ZERO, impulse)
