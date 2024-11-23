extends Control

# Reference to the Continue button in the scene tree.
@onready var continue_button: Button = $ColorRect/MarginContainer/VBoxContainer/Continue
@onready var main = "res://scenes/main.tscn"

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
	# This function loads the game state from the save file.
	# The save file format is JSON (JavaScript Object Notation).
	var file = FileAccess.open("user://save_game.json", FileAccess.READ)
	if file:
		# Create a JSON instance to parse the file content.
		var json = JSON.new()
		var save_data = json.parse(file.get_as_text())  # Parse the file's content as JSON.
		file.close()
		if save_data.error == OK:
			# If parsing succeeds, apply the saved game state.
			apply_game_state(save_data.result)  # The parsed data is in `result`.
			# Transition to the game scene.
			get_tree().change_scene_to_file("res://scenes/main.tscn")
		else:
			# Log an error if the JSON parsing fails.
			print("Failed to parse save data: ", save_data.error_string)

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
	# This function will eventually contain logic to restore the game's state
	# using the data in the provided `state` dictionary.
	var health = state["health"]
	var pos = state["position"]
	var pos_x = pos["x"]
	var pos_y = pos["y"]
	
	main.player.set_health(health)
	main.player.set_position(Vector2(pos_x, pos_y))
	
	
	print("Loaded game state:", state)
