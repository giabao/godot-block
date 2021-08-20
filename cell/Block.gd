class_name Block
extends KinematicBody2D

const CellType = GameData.CellType

# param: changed: +1 | -1
signal block_match_changed

# The following vars will be init in GameMap when create Block
var map: Array
# TODO use Vector2i when upgrade to godot 4
var col: int
var row: int
var n_col: int
var n_row: int

# must be called before add this block to scene
func init(g: GameData, col: int, row: int) -> Block:
	map = g.map
	self.col = col
	self.row = row
	n_col = map[0].size()
	n_row = map.size()
	return self
	
var moveDirection := Vector2.ZERO # UP | DOWN | LEFT | RIGHT | ZERO

func _nextPos() -> Vector2:
	return GameData.pos(
		col + int(moveDirection.x),
		row + int(moveDirection.y)
	)

func endMove():
	var moveTo := _nextPos()
	match moveDirection:
		Vector2.UP:    return position.y <= moveTo.y
		Vector2.DOWN:  return position.y >= moveTo.y
		Vector2.LEFT:  return position.x <= moveTo.x
		Vector2.RIGHT: return position.x >= moveTo.x
		_:             return true

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("blocks")

	if map[row][col] == GameData.CellType.Target:
		emit_signal("block_match_changed", +1)

func _physics_process(_delta):
	if moveDirection == Vector2.ZERO:
		return
	
	# print("%s: d=%s, v=%s, pos=%s, to=%s" % [name, moveDirection, v, position, moveTo])
	if endMove():
		var prevMatched = map[row][col] == GameData.CellType.Target
		map[row][col]
		
		col += int(moveDirection.x)
		row += int(moveDirection.y)
		moveDirection = Vector2.ZERO
		position = GameData.pos(col, row)		

		var matched = map[row][col] == GameData.CellType.Target
		if !prevMatched && matched:
			emit_signal("block_match_changed", +1)
		if prevMatched && !matched:
			emit_signal("block_match_changed", -1)
		
		return
	
	var v = Player.speed * 1.1 * moveDirection
	self.move_and_slide(v)


# d: UP | DOWN | LEFT | RIGHT
# return true if this block is not moving and can be moved to the next pos
func tryMove(d: Vector2) -> bool:
	if moveDirection != Vector2.ZERO: # moving
		return false
	if ! _canMove(d):
		return false
	moveDirection = d
	print("%s will move %s" % [name, moveDirection])
	return true


func _canMove(d: Vector2) -> bool:
	var c = col + int(d.x)
	var r = row + int(d.y)
	print("(%s, %s) -> (%s, %s) == %s" % [col, row, c, r, map[r][c]])
	if c < 0 || c >= n_col || r < 0 || r >= n_row:
		return false
	match map[r][c]:
		CellType.None, CellType.Target: return true
		_: return false
	
