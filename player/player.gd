class_name Player
extends KinematicBody2D

# Keep this in sync with the AnimationTree's state names and numbers.
enum States {
	IDLE = 0,
	RUN = 1,
	UP = 2,
	DOWN = 3,
}

const speed = Vector2(360.0, 360.0)

var v = Vector2.ZERO # velocity
var d = Vector2.ZERO # direction TODO Vector2i

onready var sprite = $Sprite
onready var sprite_scale = sprite.scale.x

func _ready():
	$AnimationTree.active = true

func _physics_process(_delta):
	v.x = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left")) * speed.x
	v.y = (Input.get_action_strength("move_down") - Input.get_action_strength("move_up")) * speed.y
	d = Vector2(
		1 if v.x > 0 else -1 if v.x < 0 else 0,
		1 if v.y > 0 else -1 if v.y < 0 else 0
	)
	if d.x != 0:
		$AnimationTree["parameters/state/current"] = States.RUN
	elif d.y == 1:
		$AnimationTree["parameters/state/current"] = States.DOWN
	elif d.y == -1:
		$AnimationTree["parameters/state/current"] = States.UP
	else:
		$AnimationTree["parameters/state/current"] = States.IDLE
	
	if d.x != 0: # flipping
		sprite.transform.x = Vector2(d.x * sprite_scale, 0)

	if d == Vector2.ZERO:
		return

	v = move_and_slide(v)
	if get_slide_count() > 0:
		var b = get_slide_collision(0).collider
		if b.is_in_group("blocks"):
			if b.canMove(d):
				b.move(d)
			# else: TODO sound ""

	
	
