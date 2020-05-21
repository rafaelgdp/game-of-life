class_name Cell

const default_bg_color = Color(0.1, 0.1, 0.1)
const bg_alive_color = Color(0.1, 0.1, 0.95)
const alive_color : Color = Color.red

var bg_color = default_bg_color
var is_alive : bool = false

func _init(a : bool) -> void:
	is_alive = a

func fill():
	bg_color = bg_alive_color

func fade():
	bg_color.b = max(bg_color.b - 0.01, 0.0)

func die():
	is_alive = false

func live():
	fill()
	is_alive = true

func get_color():
	fade()
	if is_alive:
		return alive_color
	else:
		return bg_color

func clone_props(cell):
	is_alive = cell.is_alive
	bg_color = cell.bg_color
