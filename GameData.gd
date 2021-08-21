class_name GameData

enum CellType {
	None = 0, Brick = 1, Target = 2, ILLEGAL = -1
}

const CellSize = Vector2(64, 64)
const Padding = Vector2(1, 1)

# const levels := [
# {
# 	map = [
# 		[0,1,1,1,1,1,1,0],
# 		[1,1,0,0,0,0,1,1],
# 		[1,0,2,2,0,0,0,1],
# 		[1,0,1,0,0,0,0,1],
# 		[1,0,0,0,1,0,2,1],
# 		[1,1,1,1,1,1,1,1],
# 	],
# 	blocks = [
# 		[4,3], [5,3], [6,3]
# 	],
# 	player = [5,4]
# },
# ]
# Values are in enum CellType
const map: Array = [
	[0,1,1,1,1,1,1,0],
	[1,1,0,0,0,0,1,1],
	[1,0,2,2,0,0,0,1],
	[1,0,1,0,0,0,0,1],
	[1,0,0,0,1,0,2,1],
	[1,1,1,1,1,1,1,1],
]

var blocks: Array = [ # Vector2i
	Vector2(4,3), Vector2(5,3), Vector2(6,3)
]
const playerPos = Vector2(5,4) # Vector2i

var mapRect = Rect2(Vector2.ZERO, Vector2(map[0].size(), map.size()))
func cellTypeAt(p: Vector2) -> int: # -> CellType
	if mapRect.has_point(p):
		return map[int(p.y)][int(p.x)]
	return CellType.ILLEGAL 

# return 0 | 1
func countTargetAt(p: Vector2) -> int:
	return 1 if cellTypeAt(p) else 0

func isBlankAt(pos: Vector2) -> bool:
	match cellTypeAt(pos):
		CellType.None, CellType.Target: return true
		_: return false

func countTargets() -> int:
	var ret := 0
	for row in map:
		ret += row.count(CellType.Target)
	return ret

# count matched according to blocks Array
func countMatchedTargets() -> int:
	var ret := 0
	for pos in blocks:
		ret += countTargetAt(pos)
	return ret

# p: Vector2i(col, row)
static func pos(p: Vector2) -> Vector2:
	return Padding + CellSize / 2 + (CellSize + Padding) * p

# direction: Vector2i
static func reached(node: Node2D, direction: Vector2, targetPos: Vector2) -> bool:
	match direction:
		Vector2.UP:    return node.position.y <= targetPos.y
		Vector2.DOWN:  return node.position.y >= targetPos.y
		Vector2.LEFT:  return node.position.x <= targetPos.x
		Vector2.RIGHT: return node.position.x >= targetPos.x
		_:             return true

# pos: Vector2i
# d: Vector2i = UP | DOWN | LEFT | RIGHT
func canPushBlock(pos: Vector2, d: Vector2) -> bool:
	var nextPos = pos + d
	return isBlankAt(nextPos) && !blocks.has(nextPos)

# d: Vector2i = UP | DOWN | LEFT | RIGHT
func canMovePlayer(pos: Vector2, d: Vector2) -> bool:
	var nextPos = pos + d
	return isBlankAt(nextPos) && (
		!blocks.has(nextPos) || canPushBlock(nextPos, d)
	)
