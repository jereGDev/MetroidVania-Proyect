extends CharacterBody2D

const SPEED:float = 150.0
const JUMP_VELOCITY:float = -400.0
@onready var animations = $AnimatedSprite2D

func _physics_process(delta):

	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	#Asks if it is on floor to be able to move in X vector
	
	var directionx = Input.get_axis("ui_left", "ui_right")
	if directionx:
		#Moves the player
		velocity.x = directionx * SPEED
	else:
		#End the movement
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	Animated()


#Created a function to manage all player animations
func Animated():
	#Asks if player is in floor;
	if is_on_floor():
		#Ask if velocity in X is different than 0;
		if velocity.x:
			animations.play("Run")
			#Depending on X is greater or lower than 0, it will flip the sprite;
			if velocity.x < 0:
				animations.flip_h = true
			if velocity.x > 0:
				animations.flip_h = false
		else:
			animations.play("Idle")
	else:
		#Will display the jump animation if it is not on floor
		if velocity.y < 0:
			animations.play("Jump")
		else:
			animations.play("fall")
