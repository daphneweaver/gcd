extends Control

@onready var symbol = $Symbol

func set_number(number: int):
	symbol.text = str(number)
