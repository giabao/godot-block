class_name Block
extends Movable

const speed = Player.speed * 1.1

# param: changed: +1 | -1
signal block_moved

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("blocks")

func _physics_process(_delta):
	if ! isMoving():
		return
	
	var targetPos = GameData.pos(pos + direction)
	if GameData.reached(self, direction, targetPos):
		emit_signal("block_moved", pos, direction)
		pos += direction
		direction = Vector2.ZERO
		position = targetPos
		return 
	
	move_and_slide(speed * direction)
