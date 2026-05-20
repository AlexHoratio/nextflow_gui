extends Node2D

var drag_start_window_pos = Vector2(0, 0)
var drag_start_cursor_pos = Vector2(0, 0)
var dragging = false
var hovering_drag = false

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if dragging:
		get_window().position = drag_start_window_pos + Vector2(DisplayServer.mouse_get_position()) - drag_start_cursor_pos
	
	$CanvasLayer/header_bg/ColorRect.self_modulate.a = lerp($CanvasLayer/header_bg/ColorRect.self_modulate.a, 1.0 if hovering_drag else 0.0, 0.1)
	
	queue_redraw()
	
func _draw() -> void:
	pass #draw_rect(Rect2(Vector2(0, 0), Vector2(900, 900)), Color.BLACK, false, 16, true)

func output_folder_selected(folder) -> void:
	get_node("CanvasLayer/body/w/VBoxContainer/parameters/output_dir/LineEdit").set_text(folder)

func _on_drag_window_button_down() -> void:
	drag_start_window_pos = Vector2(get_window().position)
	drag_start_cursor_pos = Vector2(DisplayServer.mouse_get_position())
	dragging = true
	
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _on_drag_window_button_up() -> void:
	dragging = false
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_x_pressed() -> void:
	get_tree().quit()

func _on_minimize_pressed() -> void:
	get_tree().root.mode = Window.MODE_MINIMIZED

func _on_generate_samplesheet_pressed() -> void:
	pass # Replace with function body.


func _on_select_output_folder_pressed() -> void:
	var dialog = FileDialog.new()
	dialog.set_file_mode(FileDialog.FILE_MODE_OPEN_DIR)
	dialog.set_access(FileDialog.ACCESS_FILESYSTEM)
	dialog.set_use_native_dialog(true)
	dialog.connect("dir_selected", output_folder_selected)
	add_child(dialog)
	dialog.popup_centered_ratio()

func _on_ready_pressed():
	#var window = Window.new()
	#add_child(window)
	var nextflow_command = "nextflow run nf-core/funcscan -r 3.0.0 -profile docker"
	nextflow_command += " --input \"" + OS.get_user_data_dir() + "/samplesheet.csv\""
	nextflow_command += " --outdir " + get_node("CanvasLayer/body/w/VBoxContainer/parameters/output_dir/LineEdit").text
	print(OS.create_process("gnome-terminal", ["-e", nextflow_command], true))


func _on_drag_window_mouse_entered() -> void:
	hovering_drag = true

func _on_drag_window_mouse_exited() -> void:
	hovering_drag = false
