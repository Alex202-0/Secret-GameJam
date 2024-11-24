extends Control

# Reference to the Continue button in the scene tree.
@onready var continue_button: Button = $ColorRect/MarginContainer/VBoxContainer/Continue

func _ready() -> void:
	# Disable the Continue button by default so the player cannot press it if there
	# is no save file available at the start.
	continue_button.disabled = true
	# Check if a save file exists and update the Continue button's state accordingly.
	update_continue_button()

# When New Game is pressed, clears any existing saved game data and starts a new game by changing the scene.
func _on_new_game_pressed() -> void:
	clear_saved_game()
	get_tree().change_scene_to_file("res://scenes/main.tscn")

func update_continue_button() -> void:
	# Enable the Continue button if a save file exists otherwise, disable the Continue button.
	continue_button.disabled = not has_saved_game()

func _on_continue_pressed() -> void:
	if has_saved_game():
		# If a save file exists, load the saved game and transition to the game scene.
		load_saved_game()

# Transitions to the options scene where the player can adjust settings when Options button is pressed
func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/temp_options.tscn")

# When the exit button is pressed, the game application is terminated
func _on_exit_pressed() -> void:
	get_tree().quit()

# Helper function to check if a save file exists.
func has_saved_game() -> bool:
	return FileAccess.file_exists("user://save_game.json")

func load_saved_game() -> void:
	# Check if the save file exists
	if not FileAccess.file_exists("user://save_game.json"):
		print("Save file does not exist")
		return

	# Open the save file
	var file = FileAccess.open("user://save_game.json", FileAccess.READ)
	if file:
		var file_content = file.get_as_text()
		file.close()

		# Create a JSON instance
		var json = JSON.new()

		# Parse the file content
		var parsed_data = json.parse_string(file_content)

		# Ensure the parsed data is a Dictionary
		if typeof(parsed_data) == TYPE_DICTIONARY:
			print("Loaded save data: ", parsed_data)
			apply_game_state(parsed_data)  # Pass the parsed Dictionary to apply_game_state
			get_tree().change_scene_to_file("res://scenes/main.tscn")  # Load the game scene
		else:
			print("Failed to load save data: Invalid JSON format or structure")
	else:
		print("Failed to open save file")



# This function clears the existing save data.
func clear_saved_game() -> void:
	if has_saved_game():
		# Open the user directory to access files.
		var dir = DirAccess.open("user://")
		if dir:
			# Attempt to remove the save file.
			var result = dir.remove("save_game.json")
			if result != OK:
				# Log an error if the file could not be deleted.
				print("Failed to delete save file: ", result)

# Applies the loaded game state to the game.
func apply_game_state(state: Dictionary) -> void:
	# Get the main scene node directly
	var main = get_tree().root.get_node("main")
	if main:
		var player = main.get_node("player")
		if player:
			
			var health = state["health"]
			var pos = state["position"]
			var pos_x = pos["x"]
			var pos_y = pos["y"]
			
			player.set_health(health)
			player.set_position(Vector2(pos_x, pos_y))
		else:
			print("Error: Player node not found in main scene!")
	else:
		print("Error: Main scene not found!")
