extends KinematicBody2D

var direction = Vector2()

export var SPEED: int = 150
var previous_x_mouse = null
var rotation_direction = 0
var rotation_speed = 0

func _ready():
	#Sets the previous mouse x to some position
	previous_x_mouse  = get_viewport().get_mouse_position()
	if not previous_x_mouse:
		previous_x_mouse = 0
	pass
	
func _physics_process(delta):
	rotation_direction = 0
	direction = Vector2()
	# TODO:
	#	make body move in the direction of the Raycast
	#	Im going to be real honest with ya'll, I don't know how I got the rotation to work
	#	but it does. 
	if Input.is_action_pressed("ui_up"):
		direction = Vector2(SPEED, 0).rotated(rotation)
	elif Input.is_action_pressed("ui_down"):
		direction = Vector2(-SPEED, 0).rotated(rotation)
		
	rotation += rotation_direction * rotation_speed * delta
		
	
	direction = move_and_slide(direction)
	
	
func _input(event):
	# event for mouse motion
	if event is InputEventMouseMotion:
		self.rotation_degrees = event.position.x / 2
		rotation_speed = event.position.x / 2
		
		# I put it over 360 because I thought it would need to be done
		rotation_direction = self.rotation_degrees / 360
