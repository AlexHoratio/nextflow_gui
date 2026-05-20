extends Control

func _ready():
	pass
	
func _process(delta):
	check_if_ready()
	
func check_if_ready() -> void:
	var ready = true
	var status_text = "\n[outline_size=8][color=#22AE63]looks ok! :)"
		
	if get_node("../w/VBoxContainer/parameters/output_dir/LineEdit").text == "":
		ready = false
		status_text = "\n[wave][color=red]specify output folder!"
	
	if get_node("../w/VBoxContainer/input").samplesheet_data == []:
		ready = false
		status_text = "\n[wave][color=red]enter input files!"
	
	$ready.disabled = !ready
	$status.text = status_text
