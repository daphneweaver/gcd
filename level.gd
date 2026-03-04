extends Control

signal activated

@onready var history = $VBoxContainer/History

var level

func _on_resized() -> void:
	if history:
		history.custom_minimum_size.y = size.x / 4

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		activated.emit(level)
