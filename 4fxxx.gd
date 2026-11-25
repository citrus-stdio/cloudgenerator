extends orbital
class_name four_fxxx

func _init() -> void:
	var max_pos = gradient_ascent(probability_density,Vector3(12.0,0,0),0.1,1000)
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
	var angular = sqrt(7.0/4)*position.x/r*(5*pow(position.x/r,2)-3) * pow((1/(4*PI)),0.5)
	
	return pow(radial*angular,2)
