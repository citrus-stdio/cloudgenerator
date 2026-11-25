extends orbital
class_name two_s

func _init() -> void:
	var max_pos = gradient_ascent(probability_density,Vector3(0,0,0),0.1,1000)
	rel_max = probability_density(max_pos)

func probability_density(position:Vector3) -> float:
	n = 2
	var Z : float = 1.0
	var r = position.length()
	var p : float = 2*r*Z/n
	# radial wave function
	var radial = (1.0/2.0/sqrt(2)) * (2-p) * pow(Z,1.5) * exp(-p/2)
	# angular wave function
	var angular = pow((1/(4*PI)),0.5)
	
	return pow(radial*angular,2)
