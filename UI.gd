extends VBoxContainer

func _on_RestartButton_pressed() -> void:
	var ev = InputEventAction.new()
	ev.action = "reset"
	ev.pressed = true
	Input.parse_input_event(ev)


func _on_QuitButton_pressed() -> void:
	var ev = InputEventAction.new()
	ev.action = "quit"
	ev.pressed = true
	Input.parse_input_event(ev)
