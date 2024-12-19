extends RigidBody2D

var rudder_rotation = 0;
var rudder_offset = Vector2(0, 100);
var rudder_length = 100;

var accel = 1200

func _init():
	rotation = PI;

func _process(delta):
	if Input.is_action_pressed("up"):
		linear_velocity += Vector2.UP.rotated(rotation) * accel * delta;
	
	var direction = 0
	if Input.is_action_pressed("left"):
		direction += -1;
	if Input.is_action_pressed("right"):
		direction += 1;
	
	rudder_rotation = 0.4 * direction;
	DebugDraw2d.arrow_vector(position, linear_velocity, Color(0,1,0));
	
	var rudder_start = transform * rudder_offset;
	var rudder_end = transform * (rudder_offset + (rudder_offset.normalized() * rudder_length).rotated(rudder_rotation));
	var rudder_vec = rudder_end - rudder_start;
	DebugDraw2d.line_vector(rudder_start, rudder_vec, Color(0,1,0));
	
	var force_pos = 0.5 * (rudder_start + rudder_end);
	
	var force = abs(sin(acos(rudder_vec.normalized().dot(linear_velocity.normalized()))));
	
	DebugDraw2d.arrow_vector(force_pos, -linear_velocity * force);
	apply_force(-linear_velocity * force, force_pos);
	
	linear_velocity *= 0.97;
	angular_velocity *= 0.9;	  
	
