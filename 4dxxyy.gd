extends orbital
class_name four_dxxyy

func _init() -> void:
	var max_pos = gradient_ascent(probability_density,Vector3(2,0,0),0.1,1000)
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
	var radial = (1.0/96/sqrt(5)) * p*p * (6-p) * pow(Z,1.5) * exp(-p/2)
	# angular wave function
	var angular = sqrt(15/(16*PI))*((position.x/r)*(position.x/r)-(position.y/r)*(position.y/r))
	
	return pow(radial*angular,2)
