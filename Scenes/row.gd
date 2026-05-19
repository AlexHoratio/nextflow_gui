extends HBoxContainer

var cell_text = ["sample", "fasta"]

func _ready() -> void:
	update_cells()
	
func _process(delta: float) -> void:
	pass
	
func update_cells() -> void:
	for cell in get_children():
		cell.get_node("Panel/Label").text = cell_text[cell.get_index()]

func set_cell_data(data) -> void:
	for child in get_children():
		child.queue_free()
	
	cell_text = data
	for cell_data in data:
		var new_cell = load("res://Prefabs/cell.tscn").instantiate()
		new_cell.set_data(cell_data)
		add_child(new_cell)

func get_ideal_width_per_cell() -> Dictionary:
	var ideal_widths = {}
	for cell in get_children():
		ideal_widths[cell.get_index()] = cell.get_ideal_width()
	
	return ideal_widths
