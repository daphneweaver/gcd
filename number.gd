extends Control

signal activated

@onready var symbol = $ColorRect/Symbol

var index: Vector2i

func set_number(number: int):
	symbol.text = str(number)

func get_number() -> int:
		return symbol.text.to_int()

func _on_color_rect_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		activated.emit(self)

func _on_color_rect_mouse_entered() -> void:
	if Input.is_mouse_button_pressed(MouseButton.MOUSE_BUTTON_LEFT):
		activated.emit(self)
