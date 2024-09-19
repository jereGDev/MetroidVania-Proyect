extends CharacterBody2D

@export var SPEED = 25
var playerChase = false
var player = null

func _physics_process(delta):
	if playerChase:
		position += (player.position - position) / SPEED


func _on_detection_area_body_entered(body):
	pass # Replace with function body.



func _on_detection_area_body_exited(body):
	pass # Replace with function body.
