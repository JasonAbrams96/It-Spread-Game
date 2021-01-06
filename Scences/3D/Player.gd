extends KinematicBody

const MOVE_SPEED = 4
const MOUSE_SENSITIVITY = 0.32

onready var animation_player = $AnimationPlayer
onready var raycast = $Camera/RayCast
onready var camera = $Camera

var motion = Vector3()
var inventory = []

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) #Make mosue invisible and centered on screen
	yield(get_tree(), "idle_frame")	# Wait a frame
	#get_tree().call_group(())
	
func _process(delta):
	#TODO: get rid of these, these are for debugging purposes
	if Input.is_key_pressed(KEY_Q):
		get_tree().quit()
	if Input.is_key_pressed(KEY_R):
		kill()

func kill():
	get_tree().reload_current_scene()
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * MOUSE_SENSITIVITY))
		camera.rotate_x(deg2rad(-event.relative.y * MOUSE_SENSITIVITY))
		
		#Clamps the movement of the camera to only be half of the player
		camera.rotation.x = clamp(camera.rotation.x, deg2rad(-90), deg2rad(90))
		
	if event is InputEventKey:
		if Input.is_action_pressed("pickup_or_use"):
			if raycast.is_colliding():
				var o = raycast.get_collider()
				if o.is_in_group("Item"):
					var name = o.name
					if o.add_to_inventory_and_kill_this(inventory, name):
						print(name + " was added to inventory")
						
			$AnimationPlayer.play("Grab")
			
			# Check ray cast to see if there is an item in front of player and pick up item
			#	TODO, change distance of raycast  to make the item seem in front of player
			#			use pickup animation
		
func move():
	if Input.is_action_pressed("ui_up"):
		motion.z -= 1
	elif Input.is_action_pressed("ui_down"):
		motion.z += 1
		
	if Input.is_action_pressed("ui_right"):
		motion.x += 1
	elif Input.is_action_pressed("ui_left"):
		motion.x -= 1
		
func _physics_process(delta):
	motion = Vector3()
	
	#Check if any movement buttons are pressed
	move()
	
	motion = motion.normalized()
	motion = motion.rotated(Vector3(0, 1, 0), rotation.y)
	motion = move_and_collide(motion * MOVE_SPEED * delta)
