extends Sprite2D

var velocity = Vector2.ZERO
var angular_velocity = 0

var accel = 1200
var angular_accel = PI

func _process(delta):
	if Input.is_action_pressed("up"):
		velocity += Vector2.UP.rotated(rotation) * accel * delta
	position += velocity * delta
	velocity *= 0.95
	
	var direction = 0
	if Input.is_action_pressed("left"):
		direction += -1
	if Input.is_action_pressed("right"):
		direction += 1
	
	rotation += angular_accel * direction * delta
