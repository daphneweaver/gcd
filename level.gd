extends Control

signal activated

@onready var margin_container = $MarginContainer
@onready var color_rect = $MarginContainer/ColorRect
@onready var history = $MarginContainer/VBoxContainer/History
@onready var puzzle = $MarginContainer/VBoxContainer/AspectRatioContainer/Frame/Puzzle

var data

func _on_resized() -> void:
	if margin_container:
		margin_container.add_theme_constant_override("margin_left", size.x / 32)
		margin_container.add_theme_constant_override("margin_right", size.x / 32)
		margin_container.add_theme_constant_override("margin_top", size.x / 32)
	if history:
		history.custom_minimum_size.y = size.x / 4

func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		activated.emit(data["level"])

func set_level(level: int) -> void:
	var file = FileAccess.open("res://levels/@.json".replace("@", str(level)), FileAccess.READ)
	var content = file.get_as_text()
	data = JSON.parse_string(content)
	data["level"] = level
	
	puzzle.populate(data["map"])

func enable() -> void:
	color_rect.mouse_filter = MOUSE_FILTER_IGNORE

func disable() -> void:
	color_rect.mouse_filter = MOUSE_FILTER_STOP
