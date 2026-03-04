extends Control

signal activated

@onready var symbol = $ColorRect/Symbol

var index: Vector2i

func set_number(number: int):
	symbol.text = str(number)

func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		activated.emit(self)
