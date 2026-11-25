extends orbital
class_name three_dzz

func _init() -> void:
	var max_pos = gradient_ascent(probability_density,Vector3(0,0,4),0.1,1000)
	rel_max = probability_density(max_pos)

func probability_density(position:Vector3) -> float:
	n = 3
	var Z : float = 1.0
	var r = position.length()
	
	#safeguard
	if r < 1e-6:
		return 0.0
		
	var p : float = 2*r*Z/n
	# radial wave function
	var radial = (1.0/9.0/sqrt(30)) * p*p * pow(Z,1.5) * exp(-p/2)
	# angular wave function
	var cos_theta = position.z / r
	var angular = sqrt(5.0/(16*PI))*(3*cos_theta*cos_theta-1)
	
	return pow(radial*angular,2)
