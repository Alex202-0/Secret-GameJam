extends Node2D

@onready var player = $player

func save_player_state() -> Dictionary:
	
	var player_data = {
		"position" : {
			"x" : player.position.x,
			"y" : player.position.y,
		},
		"health" : player.health,
	}
	return player_data

func save_game() -> void:
	var file = FileAccess.open("user://save_game.json", FileAccess.WRITE)
	var player_data = save_player_state()
	
	file.store_string(JSON.stringify(player_data))
	file.close()
	print("guardado exitoso en: ", OS.get_user_data_dir())
