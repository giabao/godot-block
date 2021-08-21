class_name Movable
extends KinematicBody2D

# const Vector2i = Vector2
const CellType = GameData.CellType

# The following vars will be init in GameMap when create Block
var g: GameData
var pos: Vector2 # current pos Vector2i(col, row)

# must be called before add this block to scene
# pos: Vector2i
func init(g: GameData, pos: Vector2) -> Movable:
	self.g = g
	self.pos = pos
	return self

# move direction: Vector2i = UP | DOWN | LEFT | RIGHT | ZERO
var direction := Vector2.ZERO

func isMoving():
	return direction != Vector2.ZERO

# d: Vector2i = UP | DOWN | LEFT | RIGHT
# @note: need implement moving logic in _physics_process
# @note should check !isMoving() && canMove(d)
func move(d: Vector2):
	direction = d
	print("%s will move %s -> %s" % [name, pos, direction])
	
