extends Label

func _on_resized() -> void:
	add_theme_font_size_override("font_size", size.y / 2)

func set_symbol(symbol: String) -> void:
	text = symbol
