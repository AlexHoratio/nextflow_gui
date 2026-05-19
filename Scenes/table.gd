extends VBoxContainer

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	pass
	
func add_row(cell_list) -> void:
	pass
	
func update_col_widths_to_ideal() -> void:
	var ideal_col_widths = {}
	var all_row_ideal_widths = []
	var longest_row_length = 0
	
	for row in get_children():
		var row_ideal_widths = row.get_ideal_width_per_cell()
		all_row_ideal_widths.append(row_ideal_widths)
		
		if row_ideal_widths.size() > longest_row_length:
			longest_row_length = row_ideal_widths.size()
			
	for col_idx in longest_row_length:
		var longest_row_width = 0
		for row in all_row_ideal_widths:
			if row[col_idx] > longest_row_width:
				longest_row_width = row[col_idx]
			
		ideal_col_widths[col_idx] = longest_row_width
			
	for row in get_children():
		for cell in row.get_children():
			cell.custom_minimum_size.x = ideal_col_widths[cell.get_index()]

func set_data(data) -> void:
	for child in get_children():
		child.queue_free()
		
	for row in data:
		var new_row = load("res://Prefabs/row.tscn").instantiate()
		new_row.set_cell_data(row)
		add_child(new_row)
		
	update_col_widths_to_ideal()
