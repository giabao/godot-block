class_name Player
extends Movable

# const BlockScene = preload("res://cell/Block.tscn")

# Keep this in sync with the AnimationTree's state names and numbers.
enum States {
	IDLE = 0,
	RUN = 1,
	UP = 2,
	DOWN = 3,
}

const speed = Vector2(360.0, 360.0)

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

func _input(e):
	if isMoving():
		return
	
	var d := direction_from_input()
	animate(d)
	
	if d != Vector2.ZERO:
		print("_input: %s" % e)
		if canMove(d):
			move(d)
	
# d: Vector2i = UP | DOWN | LEFT | RIGHT
func canMove(d: Vector2) -> bool:
	var nextPos = pos + d
	return g.isBlankAt(nextPos) && (
		!g.blocks.has(nextPos) || g.canPushBlock(nextPos, d)
	)

func animate(d: Vector2):
	match d: # Vector2i
		Vector2.RIGHT, Vector2.LEFT:
			$AnimationTree["parameters/state/current"] = States.RUN
			# flipping
			sprite.transform.x = Vector2(d.x * sprite_scale, 0)
		Vector2.DOWN:
			$AnimationTree["parameters/state/current"] = States.DOWN
		Vector2.UP:
			$AnimationTree["parameters/state/current"] = States.UP
		Vector2.ZERO:
			$AnimationTree["parameters/state/current"] = States.IDLE

func _physics_process(_delta):
	if ! isMoving():
		return

	var targetPos = GameData.pos(pos + direction)
	if GameData.reached(self, direction, targetPos):
		print("%s reached: %s -> %s" % [name, position, targetPos])
		pos += direction
		direction = Vector2.ZERO
		if direction_from_input() == Vector2.ZERO:
			position = targetPos
			$AnimationTree["parameters/state/current"] = States.IDLE

		return
	
	move_and_slide(speed * direction)
	if get_slide_count() > 0:
		var b = get_slide_collision(0).collider
		if b.is_in_group("blocks"):
			if b.isMoving():
				return
			if g.canPushBlock(b.pos, direction):
				b.move(direction)
			# else TODO sound ""

