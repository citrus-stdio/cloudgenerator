extends Camera3D
class_name camera_script

@export var target: Node3D
@export var distance: float = 0.42
@export var orbit_speed: float = 1.5

var angle: float = 0

func _process(delta):
	if target:
		if Input.is_action_pressed("left"):
			angle += orbit_speed * delta
			var x = target.global_position.x + distance * cos(angle)
			var z = target.global_position.z + distance * sin(angle)
			global_position = Vector3(x, target.global_position.y, z)
			look_at(target.global_position, Vector3.UP)
		if Input.is_action_pressed("right"):
			angle -= orbit_speed * delta
			var x = target.global_position.x + distance * cos(angle)
			var z = target.global_position.z + distance * sin(angle)
			global_position = Vector3(x, target.global_position.y, z)
			look_at(target.global_position, Vector3.UP)
