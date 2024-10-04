extends CharacterBody2D

const SPEED:float = 30.0
var playerChase:bool = false
var skeletonDamage:int = 3
var skeletonCanAttack:bool = false
var skeletonLife:int = 15
var skeletonAttackRange:float = 30.0
var isSkeletonAttacking:bool = false
var player = null
@onready var animations = $AnimatedSprite2D

#Gets the player node
#This way player is not null
func _ready():
	player = get_node("/root/TestScene/Player")
	animations.connect("animation_finished", Callable(self, "_on_animation_finished"))

#Handle skeleton movement
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if playerChase:
		var direction = (player.position - position).normalized()
		velocity.x = direction.x * SPEED
		
		if position.distance_to(player.position) <= skeletonAttackRange:
			Attack()
		
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



# Function to handle the attack
func Attack() -> void:
	if player != null and not isSkeletonAttacking:
		isSkeletonAttacking = true
		player.playerLife -= skeletonDamage 
		print("Vida del jugador: ", player.playerLife)
		animations.play("attack")

#Handle the skeleton animation
func animatedEnemy():
	if is_on_floor():
		#Ask if the absolute value of velocity in X is different than 0;
		if !isSkeletonAttacking:
			if abs(velocity.x) > 0:
				animations.play("walk")
				#Depending on X is greater or lower than 0, it will flip the sprite;
				if velocity.x < 0:
					animations.flip_h = true
				if velocity.x > 0:
					animations.flip_h = false
			else:
				animations.play("Idle")


func _on_animated_sprite_2d_animation_finished():
	if isSkeletonAttacking:
		isSkeletonAttacking = false
