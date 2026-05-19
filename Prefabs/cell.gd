extends Control

signal edited

var ideal_width = 0
var editable = true

func _ready() -> void:
	update_ideal_width()
	
func set_data(cell_text) -> void:
	$Panel/Label.text = cell_text
	update_ideal_width()
	
func update_ideal_width() -> void:
	ideal_width = get_ideal_width()

func get_ideal_width() -> float:
	return $Panel/Label.get_theme_font("font").get_string_size($Panel/Label.text).x + 16

func set_editable(e) -> void:
	editable = e
	$Panel/Label.editable = editable

func get_data() -> String:
	return $Panel/Label.text

func _on_label_text_changed(new_text):
	emit_signal("edited")
