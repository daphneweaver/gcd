extends Control

@onready var grid_container = $GridContainer
@onready var line2d = $Line2D

var number_scene = preload("res://number.tscn")
var selection: Array

func _process(_delta: float) -> void:
		if Input.is_action_just_released("left_click"):
				process_selection()

func _on_resized() -> void:
	if line2d:
		line2d.width = size.x / 80

func _on_number_activated(number) -> void:
	if selection.size() == 0:
		selection.append(number)
	elif selection[-1].index.distance_to(number.index) == 1:
		if selection.size() > 1 and selection[-2] == number:
			selection.pop_back()
		elif number not in selection:
			selection.append(number)
	update_line2d()

func populate(array: Array) -> void:
	grid_container.set_deferred("columns", array[0].size())
	for y in array.size():
		for x in array[y].size():
			var number = number_scene.instantiate()
			grid_container.add_child(number)
			number.index = Vector2i(x, y)
			number.set_number(array[y][x])
			number.activated.connect(_on_number_activated)

func process_selection() -> void:
	selection.clear()
	update_line2d()

func update_line2d() -> void:
	var points = Array()
	for number in selection:
		points.append(number.position + number.size / 2)
	line2d.points = points
