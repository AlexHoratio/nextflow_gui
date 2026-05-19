extends Control

var ideal_width = 0

func _ready() -> void:
	update_ideal_width()
	
func set_data(cell_text) -> void:
	$Panel/Label.text = cell_text
	update_ideal_width()
	
func update_ideal_width() -> void:
	ideal_width = get_ideal_width()

func get_ideal_width() -> float:
	return $Panel/Label.get_theme_font("font").get_string_size($Panel/Label.text).x + 16
