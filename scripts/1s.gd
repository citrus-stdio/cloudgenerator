extends orbital
class_name one_s

func _init() -> void:
	rel_max = probability_density(Vector3(0,0,0))

func probability_density(position:Vector3) -> float:
	n = 1.0
	var Z : float = 1.0
	var r = position.length()
	
	if r < 1e-8:
		# At r=0, the wave function is simply the normalization constant
		# For 1s: psi = (1/sqrt(PI)) * Z^1.5
		var psi_0 = (1.0 / sqrt(PI)) * pow(1.0, 1.5)
		return pow(psi_0, 2)
		
	var p : float = 2*r*Z/n
	# radial wave function
	var radial = 2 * pow(Z,1.5) * exp(-p/2)
	# angular wave function
	var angular = pow((1/(4*PI)),0.5)
	
	return pow(radial*angular,2)
