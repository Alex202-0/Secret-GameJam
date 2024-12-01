extends Node2D
#signal interactedd

@onready var interaction_area = $InteractionArea
#@onready var sprite = $AnimatedSprite2D


const lines: Array[String] = [
	"Hey there!"
]

func _ready():
	if interaction_area:
		interaction_area.interact = Callable(self, "_on_interact")
	
func _on_interact():
	print("Enemy interacted!")
	#emit_signal("interacted")
	#if interaction_area.get_overlapping_bodies().size() > 0:
		#emit_signal("interacted")
	
