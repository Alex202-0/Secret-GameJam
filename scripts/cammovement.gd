extends Camera2D

# Movement speed and position limits
@export var left_limit = 59.0  # Position for the window
@export var right_limit = 1914.0 # Position for the door
@export var smoothness = 5.0  # Higher value = faster camera movement

var target_position = 0.0  

func _ready():
	target_position = position.x

func _process(delta):
	# Get viewport dimensions
	var viewport = get_viewport()
	var mouse_position = viewport.get_mouse_position().x
	var viewport_width = get_viewport().get_visible_rect().size.x

	# Map the mouse position to the world position within the limits
	target_position = lerp(left_limit, right_limit, mouse_position / viewport_width)
	
	# Smooth movement towards the target position using delta
	position.x = lerp(position.x, target_position, smoothness * delta)
	
	# Clamp the position to ensure it stays within the limits
	position.x = clamp(position.x, left_limit, right_limit)
