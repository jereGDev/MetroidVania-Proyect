extends CharacterBody2D

@export var SPEED:int = 35
var playerChase:bool = false
var player = null
@onready var animations = $AnimatedSprite2D

#Gets the player node
#This way player is not null
func _ready():
	player = get_node("/root/BaseScene/Player")

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
	if body.name == "Player":
		playerChase = true
		print("El jugador ENTRO del area de detección")
	else:
		return


#Handle player detection for movement when players leaves the area
func _on_detection_area_body_exited(body):
	if body.name == "Player":
		playerChase = false
		print("El jugador SALIO del area de detección")
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
