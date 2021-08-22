class_name Player
extends Movable

# Keep this in sync with the AnimationTree's state names and numbers.
enum AnimStates {
	IDLE = 0,
	RUN = 1,
	UP = 2,
	DOWN = 3,
}

const speed = Vector2(480.0, 480.0)

onready var sprite = $Sprite
onready var sprite_scale = sprite.scale.x

func _ready():
	$AnimationTree.active = true
    #warning-ignore:return_value_discarded
	$StateMachine.connect("transitioned", self, "_on_state_transitioned")

func animate(d: Vector2):
	match d: # Vector2i
		Vector2.RIGHT, Vector2.LEFT:
			$AnimationTree["parameters/state/current"] = AnimStates.RUN
			# flipping
			sprite.transform.x = Vector2(d.x * sprite_scale, 0)
		Vector2.DOWN:
			$AnimationTree["parameters/state/current"] = AnimStates.DOWN
		Vector2.UP:
			$AnimationTree["parameters/state/current"] = AnimStates.UP
		Vector2.ZERO:
			$AnimationTree["parameters/state/current"] = AnimStates.IDLE



static func direction_from_input() -> Vector2:
	return (
		Vector2.RIGHT if Input.get_action_strength("move_right") > 0 else
		Vector2.LEFT  if Input.get_action_strength("move_left") > 0 else 
		Vector2.DOWN  if Input.get_action_strength("move_down") > 0 else
		Vector2.UP    if Input.get_action_strength("move_up") > 0 else
		Vector2.ZERO
	)

var next_direction := Vector2.ZERO
func _on_state_transitioned(new_state):
	if new_state == "Moving":
		next_direction = Vector2.ZERO
##########
var swipe_start := Vector2.ZERO
const minimum_drag = 100

func calc_next_direction(e):
	var d := Vector2.ZERO
	if e is InputEventScreenTouch:
		print("touch: %s, %s" % [e.pressed, e.get_position()])
		if e.pressed:
			swipe_start = e.get_position()
		else:
			d = _calculate_swipe(e.get_position())
	else:
		d = direction_from_input()
	if d != Vector2.ZERO:
		next_direction = d

func _calculate_swipe(swipe_end: Vector2) -> Vector2:
	if swipe_start == Vector2.ZERO: 
		return Vector2.ZERO
	
	var swipe = swipe_end - swipe_start
	return (
		Vector2.RIGHT if swipe.x > minimum_drag else
		Vector2.LEFT  if swipe.x < -minimum_drag else
		Vector2.DOWN  if swipe.y > minimum_drag else
		Vector2.UP    if swipe.y < -minimum_drag else
		Vector2.ZERO
	)
