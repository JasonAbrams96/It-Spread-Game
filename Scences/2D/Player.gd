extends KinematicBody2D

var direction = Vector2()
export var SPEED = 200
var previous_x_mouse = null

func _ready():
	previous_x_mouse  = get_viewport().get_mouse_position()
	if not previous_x_mouse:
		previous_x_mouse = 0
	pass
	
func _physics_process(delta):
	# TODO:
	#	make body move in the direction of the Raycast
	
	pass
	
	
func _input(event):
	
	# event for mouse motion
	if event is InputEventMouseMotion:
		self.rotation_degrees = event.position.x
