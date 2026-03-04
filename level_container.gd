extends Control

signal opened
signal closed

@onready var margin_container = $MarginContainer
@onready var aspect_ratio_container = $MarginContainer/AspectRatioContainer
@onready var h_box_container = $MarginContainer/AspectRatioContainer/HBoxContainer

var puzzle_scene = preload("res://level.tscn")
var number_of_levels
var state = {"open": true, "level": 1}

func _ready() -> void:
	number_of_levels = 10
	for i in range(number_of_levels):
		var puzzle = puzzle_scene.instantiate()
		puzzle.level = i + 1
		puzzle.activated.connect(_on_puzzle_activated)
		h_box_container.add_child(puzzle)

func _on_resized() -> void:
	if margin_container:
		update_margins(false)
	if aspect_ratio_container:
		aspect_ratio_container.ratio = h_box_container.get_children().size() * size.x / size.y

func _on_puzzle_activated(level: int):
	if state["level"] == level:
		open()
	else:
		state["level"] = level
		update_margins(true)

func open() -> void:
	state["open"] = true
	update_margins(true)
	opened.emit()
	
func close() -> void:
	state["open"] = false
	update_margins(true)
	closed.emit()

func update_margins(animate: bool) -> void:
	var h_margin
	var v_margin
	if state["open"]:
		h_margin = (number_of_levels + 1 - 2 * state["level"]) * size.x / 2
		v_margin = 0
	else:
		h_margin = (number_of_levels + 1 - 2 * state["level"]) * size.x / 4
		v_margin = size.y / 4
		
	if animate:
		var tween = create_tween()
		tween.parallel().tween_property(margin_container, "theme_override_constants/margin_top", v_margin, 0.1)
		tween.parallel().tween_property(margin_container, "theme_override_constants/margin_bottom", v_margin, 0.1)
		tween.parallel().tween_property(margin_container, "theme_override_constants/margin_left", h_margin, 0.1)
		tween.parallel().tween_property(margin_container, "theme_override_constants/margin_right", -h_margin, 0.1)
		tween.set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT)
	else:
		margin_container.add_theme_constant_override("margin_top", v_margin)
		margin_container.add_theme_constant_override("margin_botton", v_margin)
		margin_container.add_theme_constant_override("margin_left", h_margin)
		margin_container.add_theme_constant_override("margin_right", -h_margin)
