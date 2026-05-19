extends Control


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
	
	$files/SmoothScrollContainer/table.set_data(data)
	
func dir_selected(dir) -> void:
	print(dir)

func _on_select_samplesheet_pressed() -> void:
	pass # Replace with function body.
