extends Node

const CONTROLLER_DEADZONE = 0.2
const MOVEMENT_SPEED = 0

func _ready():
  # Register event to monitor if joystick connected
  Input.connect("joy_connection_changed", self, "joy_con_changed")

func _process(delta):
	if Input.get_connected_joypads().size() > 0:
		var deadZone = 0.2
		# Controller movement
		var joystick_vector = Vector2(-Input.get_joy_axis(0, 5), Input.get_joy_axis(0, 4))
		
		if joystick_vector.length() < CONTROLLER_DEADZONE:
			joystick_vector = Vector2(0, 0)
		else:
			joystick_vector = joystick_vector.normalized() * ((joystick_vector.length() - CONTROLLER_DEADZONE) / (1 - CONTROLLER_DEADZONE))
			joystick_vector = joystick_vector.normalized()

		var dMove = delta * MOVEMENT_SPEED
		var movement_forward = get_parent().get_node("Player_Camera").global_transform.basis.z.normalized() * joystick_vector.x * dMove
		var movement_right = get_parent().get_node("Player_Camera").global_transform.basis.x.normalized() * joystick_vector.y * dMove
		movement_forward.y = 0
		movement_right.y = 0
		
		if movement_right.length() + movement_forward.length() > 0:
			get_parent().translate(movement_right + movement_forward)
