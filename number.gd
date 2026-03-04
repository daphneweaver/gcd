extends Control

@onready var label = $Label

func _on_resized() -> void:
	if label:
		label.add_theme_font_size_override("font_size", size.y / 2)

func set_number(number: int):
	label.text = str(number)
