extends CharacterBody2D

const SPEED:float = 30.0
var playerChase:bool = false
var player = null
@onready var animations = $AnimatedSprite2D

#Gets the player node
#This way player is not null
func _ready():
	player = get_node("/root/TestScene/Player")

#Handle skeleton movement
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if playerChase:
		var direction = (player.position - position).normalized()
		velocity.x = direction.x * SPEED
		
	move_and_slide()
	animatedEnemy()

#Handle player detection for movement when players enters the area
func _on_detection_area_body_entered(body):
	if body.name == "Player":
		playerChase = true
	else:
		return

#Handle player detection for movement when players leaves the area
func _on_detection_area_body_exited(body):
	if body.name == "Player":
		playerChase = false
		velocity.x = 0
		velocity.y = 0
	else:
		return

#Handle the skeleton animation
func animatedEnemy():
	if is_on_floor():
		#Ask if the absolute value of velocity in X is different than 0;
		if abs(velocity.x) > 0:
			animations.play("walk")
			#Depending on X is greater or lower than 0, it will flip the sprite;
			if velocity.x < 0:
				animations.flip_h = true
			if velocity.x > 0:
				animations.flip_h = false
		else:
			animations.play("Idle")
