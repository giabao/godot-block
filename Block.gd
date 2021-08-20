class_name Block
extends KinematicBody2D

const G = preload("GameData.gd") # TODO

# The following vars will be init in GameMap when create Block
var map: Array
# TODO use Vector2i when upgrade to godot 4
var col: int
var row: int
var n_col: int
var n_row: int

# must be called before add this block to scene
func init(g: G, col: int, row: int) -> Block:
	map = g.map
	self.col = col
	self.row = row
	n_col = map[0].size()
	n_row = map.size()
	return self
	
var moveDirection := Vector2.ZERO # UP | DOWN | LEFT | RIGHT | ZERO
# temp var to store position we want block to move to
var moveTo := Vector2.ZERO

func endMove():
	match moveDirection:
		Vector2.UP:    return position.y <= moveTo.y
		Vector2.DOWN:  return position.y >= moveTo.y
		Vector2.LEFT:  return position.x <= moveTo.x
		Vector2.RIGHT: return position.x >= moveTo.x
		_:             return true

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("blocks")

func _physics_process(_delta):
	if moveDirection == Vector2.ZERO:
		return
	
	# print("%s: d=%s, v=%s, pos=%s, to=%s" % [name, moveDirection, v, position, moveTo])
	if endMove():
		position = moveTo
		col += int(moveDirection.x)
		row += int(moveDirection.y)
		moveDirection = Vector2.ZERO
		return
	
	var v = Player.speed * 1.1 * moveDirection
	self.move_and_slide(v)
	if get_slide_count() > 0:
		var collider = get_slide_collision(0).collider
		print("%s: v=%s, c=%s" % [name, v, collider.name])

# d: UP | DOWN | LEFT | RIGHT
func move(d: Vector2):
	print("%s move d=%s" % [name, d])
	if moveDirection != Vector2.ZERO:
		return
	moveDirection = d
	moveTo = GameData.pos(
		col + int(moveDirection.x),
		row + int(moveDirection.y)
	)
	print("%s moveTo %s" % [name, moveTo])


func canMove(d: Vector2) -> bool:
	var c = col + int(d.x)
	var r = row + int(d.y)
	print("%s, %s, %s, %s, %s" % [col, row, c, r, map[r][c]])
	if c < 0 || c >= n_col || r < 0 || r >= n_row:
		return false
	match map[r][c]:
		G.CellType.None, G.CellType.Target: return true
		_: return false
	
