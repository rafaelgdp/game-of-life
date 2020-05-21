extends Node

signal fps_updated(new_fps)

var fps : float = 10.0 setget set_fps

func set_fps(v):
	fps = clamp(v, 0.5, 60.0)
	emit_signal("fps_updated", fps)
