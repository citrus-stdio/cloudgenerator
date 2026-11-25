extends orbital
class_name four_fxyz

func _init() -> void:
	var max_pos = gradient_ascent(probability_density,Vector3(10,10,10),0.1,1000)
	rel_max = probability_density(max_pos)
	
func probability_density(position:Vector3) -> float:
	n = 4
	var Z : float = 1.0
	var r = position.length()
	
	#safeguard
	if r < 1e-6:
		return 0.0
		
	var p : float = 2*r*Z/n
	# radial wave function
	var radial = (1.0/96/sqrt(35)) * p * p * p * pow(Z,1.5) * exp(-p/2)
	# angular wave function
	var angular = sqrt(105.0/4)*2*(position.x/r)*(position.y/r)*(position.z/r)* pow((1/(4*PI)),0.5)
	
	return pow(radial*angular,2)
