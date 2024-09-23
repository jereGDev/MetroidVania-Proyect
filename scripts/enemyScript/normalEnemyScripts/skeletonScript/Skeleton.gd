extends CharacterBody2D

@export var SPEED:int = 25
var playerChase:bool = false
var player = null
@onready var animations = $AnimatedSprite2D

func _ready():
	player = get_node("/root/BaseScene/Player/Player")
	if player:
		print("PILLA AL JUGADOR")

#Handle skeleton movement
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if playerChase:
		position += (player.position - position) / SPEED
	move_and_slide()
	animatedEnemy()

#Handle player detection for movement when players enters the area
func _on_detection_area_body_entered(body):
	if body.name == "player":
		playerChase = true
	else:
		return


#Handle player detection for movement when players leaves the area
func _on_detection_area_body_exited(body):
	if body.name == "player":
		playerChase = false
	else:
		return

#Handle the skeleton animation
func animatedEnemy():
	if is_on_floor():
		if velocity.x:
			animations.play("walk")
			if velocity.x < 0:
				animations.flip_h = true
			if velocity.x > 0:
				animations.flip_h = false
		else:
			animations.play("Idle")
