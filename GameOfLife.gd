# Author: Rafael Pontes
# This is an implementation of the Game of Life celular automaton, which was created by John Conway in 1970.

extends Node2D

var cell_buffer = []
var width = 73
var height = 48
var buffer_index = 0

func _ready() -> void:
	if OS.get_name() == "HTML5":
		$CanvasLayer/UI/QuitButton.disabled = true
		$CanvasLayer/UI/QuitButton.visible = false
	
	randomize()
	cell_buffer.append([])
	cell_buffer.append([])
	for i in range(width):
		cell_buffer[0].append([])
		cell_buffer[1].append([])
		for j in range(height):
			var a = true if randi() % 2 == 0 else false
			cell_buffer[0][i].append(Cell.new(a))
			cell_buffer[1][i].append(Cell.new(a))
	update()

func _on_UpdateTimer_timeout() -> void:
	update_cell_buffer()
	
var has_update = true

func _process(delta: float) -> void:
	if has_update:
		update()
		has_update = false

const cell_dist = 12
const rsize = Vector2(cell_dist, cell_dist)

func _draw() -> void:
	var pos = rsize
	var stroke_color = Color.black
	for x in range(width):
		for y in range(height):
			draw_rect(Rect2(pos + Vector2(x * rsize.x, y * rsize.y), rsize), cell_buffer[buffer_index][x][y].get_color())
	for x in range(width):
		draw_line(pos + Vector2(x * rsize.x, 0), pos + (Vector2( x * rsize.x, height * cell_dist)), stroke_color)
	for y in range(height):
		draw_line(pos + Vector2(0, y * rsize.y), pos + (Vector2(width * cell_dist, y * rsize.y)), stroke_color)

func update_cell_buffer():
	check_all()
	has_update = true

func check_all():
	var next_buffer_index = (buffer_index + 1) % 2
	for x in range(width):
		for y in range(height):
			var n = get_neighbors(x, y)
			if cell_buffer[buffer_index][x][y].is_alive and (n < 2 or n > 3):
				cell_buffer[next_buffer_index][x][y].die()
			elif n == 3:
				cell_buffer[next_buffer_index][x][y].live()
			else:
				cell_buffer[next_buffer_index][x][y].clone_props(cell_buffer[buffer_index][x][y])
	buffer_index = next_buffer_index

func get_neighbors(x : int, y : int) -> int:
	var neighbors : int = 0
	for xi in range(-1, 2):
		for yi in range(-1, 2):
			var cx = wrapi(x + xi, 0, width)
			var cy = wrapi(y + yi, 0, height)
			if cx == x and cy == y:
				continue
			if cell_buffer[buffer_index][cx][cy].is_alive:
				neighbors += 1
	return neighbors

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("reset"):
		get_tree().reload_current_scene()
	elif event.is_action_pressed("quit"):
		get_tree().quit()
