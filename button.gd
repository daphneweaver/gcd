extends Control

signal activated

@export var text: String:
	set(text):
		$AspectRatioContainer/MarginContainer/Frame/Label.text = text

@onready var margin_container = $AspectRatioContainer/MarginContainer
@onready var label = $AspectRatioContainer/MarginContainer/Frame/Label

func _on_resized() -> void:
	if label:
		label.add_theme_font_size_override("font_size", size.y / 2)

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		activated.emit()

func enable() -> void:
	set_margins(0)

func disable() -> void:
	set_margins(size.x / 4)

func set_margins(offset: int) -> void:
	var tween = create_tween()
	tween.parallel().tween_property(margin_container, "theme_override_constants/margin_top", offset, 0.1)
	tween.parallel().tween_property(margin_container, "theme_override_constants/margin_bottom", -offset, 0.1)
	tween.set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT)
