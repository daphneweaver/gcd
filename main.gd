extends Control

@onready var margin_container = $Background/MarginContainer
@onready var level_container = $Background/MarginContainer/VBoxContainer/LevelContainer
@onready var button_container = $Background/MarginContainer/VBoxContainer/ButtonContainer
@onready var close_button = $Background/MarginContainer/VBoxContainer/ButtonContainer/CloseButton

func _ready() -> void:
	resized.emit()

func _on_resized() -> void:
	if margin_container:
		margin_container.add_theme_constant_override("margin_bottom", size.x / 32)
	if button_container:
		button_container.custom_minimum_size.y = size.x / 4

func _on_close_button_activated() -> void:
	level_container.close()

func _on_puzzle_container_closed() -> void:
	close_button.disable()
	
func _on_puzzle_container_opened() -> void:
	close_button.enable()
