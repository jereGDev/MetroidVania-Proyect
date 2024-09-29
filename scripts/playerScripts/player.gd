extends CharacterBody2D

const SPEED:float = 150.0
const JUMP_VELOCITY:float = -400.0
var playerLife:int = 50
var playerAttackStat:int = 5
var playerCanAttack:bool = true
var playerAttacking:bool = false
var enemy = null
@onready var animations = $AnimatedSprite2D

#Show the player life in console
func _ready():
	print(playerLife)

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Asks if it is on floor to be able to move in X vector
	
	var directionx = Input.get_axis("MoveLeft", "MoveRight")
	
	#If player is not attacking the player can move
	
	if !playerAttacking:
		if directionx:
			#Moves the player
			velocity.x = directionx * SPEED
		else:
			#End the movement
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			if Input.is_action_just_pressed("Attack"):
				playerAttacking = true

	else:
		animations.play("Attack1")
		await (animations.animation_finished)
		playerAttacking = false
	move_and_slide()
	Animated()

#func Attack():
	#if Input.is_action_just_pressed("ui_accept"):
		#playerCanAttack = true
	#else:
		#playerCanAttack = false

#Created a function to manage all player animations
func Animated():
	#Asks if player is in floor;
	if is_on_floor():
		#Ask if velocity in X is different than 0;
		if !playerAttacking:
			if velocity.x:
				animations.play("Run")
			#Depending on X is greater or lower than 0, it will flip the sprite;
			else:
				animations.play("Idle")
			if velocity.x < 0:
				animations.flip_h = true
			if velocity.x > 0:
				animations.flip_h = false
		else:
			animations.play("Attack1")
			await (animations.animation_finished)
			playerAttacking = false
	else:
		#Will display the jump animation if it is not on floor
		if velocity.y < 0:
			animations.play("Jump")
		else:
			animations.play("fall")
