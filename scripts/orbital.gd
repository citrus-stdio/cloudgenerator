extends Resource
class_name orbital

@export var n : float
@export var m : int
@export var l : int
@export var rel_max : float


func gradient(f:Callable,pos:Vector3)->Vector3:
	var delta = 1e-6
	return Vector3((f.call(Vector3(pos.x+delta,pos.y,pos.z))-f.call(pos))/delta,(f.call(Vector3(pos.x,pos.y+delta,pos.z))-f.call(pos))/delta,(f.call(Vector3(pos.x,pos.y,pos.z+delta))-f.call(pos))/delta)
	
func gradient_ascent(f:Callable,initial_guess:Vector3,learning_rate:float,iterations:int) -> Vector3:
	var current_pos = initial_guess
	for i in range(iterations):
		var grad = gradient(f,current_pos)
		if grad.length() < 1e-6:
			break
		current_pos += grad * learning_rate * pow(0.95,i)
	return current_pos
	
func probability_density(_position:Vector3) -> float:
	return 0.0
