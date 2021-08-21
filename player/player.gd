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

static func direction_from_input() -> Vector2:
	return (
		Vector2.RIGHT if Input.get_action_strength("move_right") > 0 else
		Vector2.LEFT  if Input.get_action_strength("move_left") > 0 else 
		Vector2.DOWN  if Input.get_action_strength("move_down") > 0 else
		Vector2.UP    if Input.get_action_strength("move_up") > 0 else
		Vector2.ZERO
	)


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

