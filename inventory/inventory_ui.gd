extends Control


var isOpen = false


func _ready() -> void:
	close()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		if isOpen:
			close()
		else:
			open()


func close():
	visible = false
	isOpen = false

func open():
	visible = true
	isOpen = true
