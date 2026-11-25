extends Node

@export var nucleus: Node3D
var flip: int = 1

func _ready():
	pass
func _process(_delta) -> void:
	if Input.is_action_just_pressed("halve"):
		flip += 1
	if flip%2 == 0:
		for i in nucleus.get_children():
			if i.position.z >= 0 and i.position.y < 100:
				i.position.y += 1000
	if flip%2 == 1:
		for j in nucleus.get_children():
			if j.position.y >= 100:
				j.position.y -= 1000
