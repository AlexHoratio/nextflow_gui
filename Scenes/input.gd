extends Control

var samplesheet_data = []

func _ready():
	pass

func generate_samplesheet() -> void:
	var samplesheet_file = FileAccess.open("user://samplesheet.csv", FileAccess.WRITE)
	
	var samplesheet_text = ""
	
	for row in samplesheet_data:
		for cell_idx in range(row.size()):
			samplesheet_text += ("," if cell_idx > 0 else "") + row[cell_idx]
			
		samplesheet_text += "\n"
		
	samplesheet_file.store_string(samplesheet_text)
	samplesheet_file.close()

func _on_select_files_pressed() -> void:
	var dialog = FileDialog.new()
	dialog.set_file_mode(FileDialog.FILE_MODE_OPEN_FILES)
	dialog.set_access(FileDialog.ACCESS_FILESYSTEM)
	dialog.set_use_native_dialog(true)
	dialog.connect("files_selected", files_selected)
	add_child(dialog)
	dialog.popup_centered_ratio()

func _on_select_folder_pressed() -> void:
	var dialog = FileDialog.new()
	dialog.set_file_mode(FileDialog.FILE_MODE_OPEN_DIR)
	dialog.set_access(FileDialog.ACCESS_FILESYSTEM)
	dialog.set_use_native_dialog(true)
	dialog.connect("dir_selected", dir_selected)
	add_child(dialog)
	dialog.popup_centered_ratio()
	
func files_selected(files) -> void:
	var data = [["sample", "fasta"]]
	var regex = RegEx.new()
	regex.compile("(?<=/)[^/]+$")
	print(regex.search("test/testasdf/yey").get_string())
	
	for file in files:
		data.append([regex.search(file).get_string(), file])
	
	samplesheet_data = data
	
	$files/SmoothScrollContainer/table.set_data(data)
	generate_samplesheet()
	
func dir_selected(dir) -> void:
	print(dir)

func _on_select_samplesheet_pressed() -> void:
	pass # Replace with function body.
