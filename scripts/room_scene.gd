extends Node2D

# Nodes
@onready var door_area = $doornode/Area2D
@onready var window_area = $windownode/Area2D
@onready var desk_area = $desktnode/Area2D

func _ready():
	# Connect the input_event signal for each Area2D to the same handler, binding the area
	door_area.connect("input_event", Callable(self, "_on_area_input").bind(door_area))
	window_area.connect("input_event", Callable(self, "_on_area_input").bind(window_area))
	desk_area.connect("input_event", Callable(self, "_on_area_input").bind(desk_area))

func _on_area_input(viewport, event, shape_idx, area):
	if event is InputEventMouseButton and event.pressed:
		if area == door_area:
			print("Interacting with the door...")
			_interact_with_door()
		elif area == window_area:
			print("Peeking through the window...")
			_interact_with_window()
		elif area == desk_area:
			print("Using the desk...")
			_interact_with_desk()

func _interact_with_door():
	print("Door logic executed.")

func _interact_with_window():
	print("Window logic executed.")

func _interact_with_desk():
	print("Desk logic executed.")
