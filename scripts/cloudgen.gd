extends Node

var electron = preload("res://scenes/electron.tscn")

# in this simulation, I have been using 1:1, 1 Bohr radius to 1 meter
var bohr_r: float = 1.0

# stop parity
var flip: int = 0

var n: int = 1
var l: int = 1
var total_energies: int = 10
var frame_budget: int = 10
var generating : bool = true

@onready var parent = self
@onready var cam: camera_script = get_node("../Camera3D")

@export var cloud: orbital
@export var view_radius: float
@export var instances: int
@export var time_between: float = 0.0001

func _process(_delta) -> void:
	
	# stop parity
	if Input.is_action_just_pressed("stop"):
		flip += 1
		generating = false
		if flip % 2 == 1:
			start_generating()

	# change energy states
	if Input.is_action_just_pressed("arrow_left"):
		l -= 1
		update_state()

	if Input.is_action_just_pressed("arrow_right"):
		l += 1
		update_state()

	if Input.is_action_just_pressed("up"):
		n += 1
		update_state()

	if Input.is_action_just_pressed("down"):
		n -= 1
		update_state()


func start_generating():
	if generating:
		return
	generating = true
	generate_cloud()


func update_state():
	# stop generating
	flip += 1
	generating = false

	if n % total_energies == 0:
		cam.distance = 0.3
		cloud = one_s.new()
		view_radius = 5
		instances = 400
		print("one s")

	if n % total_energies == 1:
		cam.distance = 0.32
		cloud = two_s.new()
		instances = 800
		view_radius = 7
		print("two s")

	if n % total_energies == 2:
		cam.distance = 0.34
		instances = 1000
		view_radius = 7

		if l % 3 == 0:
			cloud = two_px.new()
			print("two px")
		if l % 3 == 1:
			cloud = two_py.new()
			print("two py")
		if l % 3 == 2:
			cloud = two_pz.new()
			print("two pz")

	if n % total_energies == 3:
		cam.distance = 0.36
		instances = 700
		view_radius = 10
		cloud = three_s.new()
		print("three s")

	if n % total_energies == 4:
		cam.distance = 0.36
		instances = 1000
		view_radius = 10

		if l % 3 == 0:
			cloud = three_px.new()
			print("three px")
		if l % 3 == 1:
			cloud = three_py.new()
			print("three py")
		if l % 3 == 2:
			cloud = three_pz.new()
			print("three pz")

	if n % total_energies == 5:
		cam.distance = 0.38
		instances = 1000
		view_radius = 10

		if l % 5 == 0:
			cloud = three_dzz.new()
			print("three dzz")
		if l % 5 == 1:
			cloud = three_dyz.new()
			print("three dyz")
		if l % 5 == 2:
			cloud = three_dxy.new()
			print("three dxy")
		if l % 5 == 3:
			cloud = three_dxz.new()
			print("three dxz")
		if l % 5 == 4:
			cloud = three_dxxyy.new()
			print("three dxxyy")

	if n % total_energies == 6:
		instances = 5000
		view_radius = 17
		cam.distance = 0.4
		cloud = four_s.new()
		print("four s")
		
	if n % total_energies == 7:
		instances = 8000
		view_radius = 24
		cam.distance = 0.42

		if l % 3 == 0:
			cloud = four_px.new()
			print("four px")
		if l % 3 == 1:
			cloud = four_py.new()
			print("four py")
		if l % 3 == 2:
			cloud = four_pz.new()
			print("four pz")
			
	if n % total_energies == 8:
		instances = 9000
		view_radius = 25
		cam.distance = 0.44

		if l % 5 == 0:
			cloud = four_dzz.new()
			print("four dzz")
		if l % 5 == 1:
			cloud = four_dyz.new()
			print("four dyz")
		if l % 5 == 2:
			cloud = four_dxy.new()
			print("four dxy")
		if l % 5 == 3:
			cloud = four_dxz.new()
			print("four dxz")
		if l % 5 == 4:
			cloud = four_dxxyy.new()
			print("four dxxyy")
	if n % total_energies == 9:
		instances = 9000
		view_radius = 30
		cam.distance = 0.6
		frame_budget = 20

		if l % 7 == 0:
			cloud = four_fzzz.new()
			print("four fzzz")
		if l % 7 == 1:
			cloud = four_fxxx.new()
			print("four fxxx")
		if l % 7 == 2:
			cloud = four_fyyy.new()
			print("four fyyy")
		if l % 7 == 3:
			cloud = four_fzxxyy.new()
			print("four fzxxyy")
		if l % 7 == 4:
			cloud = four_fxzzyy.new()
			print("four fxzzyy")
		if l % 7 == 5:
			cloud = four_fyzzxx.new()
			print("four fyzzxx")
		if l % 7 == 6:
			cloud = four_fxyz.new()
			print("four fxyz")
			
			
	# resume generation
	start_cleanup()
	flip += 1


func unit_vector() -> Vector3:
	var z = randf_range(-1, 1)
	var theta = randf_range(0, 2 * PI)
	return Vector3(
		sqrt(1 - z * z) * cos(theta),
		sqrt(1 - z * z) * sin(theta),
		z
	)


func start_cleanup():
	while parent.get_child_count()>instances:
		var remove_count = min(50, parent.get_child_count() - 2)
		for i in range(remove_count):
			if parent.get_child_count() <= 2:
				break
			var child = parent.get_child(2)
			parent.remove_child(child)
			child.queue_free()
		await get_tree().process_frame
	start_generating()


func generate_cloud():
	while true:
		for i in range(frame_budget):
			var current_pos = find_plausible_pos(view_radius)
			var new_electron = electron.instantiate()
			parent.add_child(new_electron)
			new_electron.position = current_pos
		await get_tree().create_timer(time_between).timeout

		var children = parent.get_children()
		if children.size() >= instances:
			var iterate: int = 0
			var cap: int = frame_budget * 2
			if children.size():
				while iterate <= cap:
					var child = children[iterate + 2]
					parent.remove_child(child)
					child.queue_free()
					iterate += 1
		if flip % 2 == 0:
			break


func find_plausible_pos(r_bound: float):
	while true:
		var pos: Vector3 = Vector3(
			randf_range(-r_bound, r_bound),
			randf_range(-r_bound, r_bound),
			randf_range(-r_bound, r_bound)
		)

		if pos.length() > r_bound:
			continue

		if randf() * cloud.rel_max <= cloud.probability_density(pos):
			return pos
