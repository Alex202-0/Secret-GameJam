extends CharacterBody2D

var inventario = []
var health = 100
const SPEED = 300.0
@onready var anim = $AnimatedSprite2D

func set_health(newhealth: int) -> void:
	health = newhealth
	print("new health is ", health)
	
func set_pos(new_pos: Vector2) -> void:
	position = new_pos
	print("new postion is ", position) 

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if direction > 0:
		anim.play("walk")
		anim.flip_h = false
	elif direction < 0:
		anim.play("walk")
		anim.flip_h = true
	else:
		anim.play("idle")

	move_and_slide()
