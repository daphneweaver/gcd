extends Control

signal activated

@export var symbol: String:
	set(symbol):
		$AspectRatioContainer/MarginContainer/Frame/Symbol.text = symbol

@onready var margin_container = $AspectRatioContainer/MarginContainer

func _on_gui_input(event: InputEvent) -> void:
	print("bang")
	if event.is_action_pressed("left_click"):
		activated.emit()

func enable() -> void:
	set_margins(0)

func disable() -> void:
	set_margins(1.5 * size.y)

func set_margins(offset: int) -> void:
	var tween = create_tween()
	tween.parallel().tween_property(margin_container, "theme_override_constants/margin_top", offset, 0.1)
	tween.parallel().tween_property(margin_container, "theme_override_constants/margin_bottom", -offset, 0.1)
	tween.set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN_OUT)
