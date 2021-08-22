class_name BlockMoving
extends State

var block: Block

func _ready() -> void:
	# The states are children of the `Player` node so their `_ready()` callback will execute first.
	# That's why we wait for the `owner` to be ready first.
	yield(owner, "ready")
	# The `as` keyword casts the `owner` variable to the `Player` type.
	# If the `owner` is not a `Player`, we'll get `null`.
	block = owner as Block
	# This check will tell us if we inadvertently assign a derived state script
	# in a scene other than `Player.tscn`, which would be unintended. This can
	# help prevent some bugs that are difficult to understand.
	assert(block != null)

var speed = Player.speed * 1.3
var direction: Vector2

func enter(msg := {}) -> void:
	direction = msg.direction
	assert(direction != Vector2.ZERO)
	
func physics_update(_delta: float) -> void:
	var targetPos = GameData.pos(block.pos + direction)
	if GameData.reached(block, direction, targetPos):
		print("%s reached: %s -> %s" % [block.name, block.position, targetPos])
		block.pos += direction
		block.position = targetPos
		state_machine.transition_to("Idle")
		return 

    #warning-ignore:return_value_discarded
	block.move_and_slide(speed * direction)
