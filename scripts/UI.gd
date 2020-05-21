extends VBoxContainer

func _ready():
	Global.connect("fps_updated", self, "on_fps_updated")
	update_speed_label(Global.fps)
	$HSlider.value = Global.fps

func on_fps_updated(fps):
	update_speed_label(fps)

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

func _on_HSlider_value_changed(value: float) -> void:
	Global.fps = value

func update_speed_label(value : float):
	$SpeedSliderLabel.bbcode_text = "FPS: [color=white]" + str("%.1f" % value) + "[/color]"
