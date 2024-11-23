extends Control

@onready var player = get_node("res://scenes/player.tscn")

func resume() -> void:
	get_tree().paused = false
	$PanelContainer.visible = false
	
func pause() -> void:
	get_tree().paused = true
	$PanelContainer.visible = true

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("esc"):
		if get_tree().paused == false:
			pause()
		else:
			resume()

func _on_resume_pressed() -> void:
	resume()


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/temp_options.tscn")
	
	

func _on_quit_pressed() -> void:
	get_tree().quit()
	

func _on_save_game_pressed() -> void:
	
	var main = get_tree().root.get_node("main")
	
	if main:
		main.save_game()
