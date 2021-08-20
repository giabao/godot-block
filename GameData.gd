class_name GameData

enum CellType {
	None, Brick, Target,
}

const CellSize = Vector2(64, 64)
const Padding = Vector2(1, 1)

# Values are in enum CellType
const map: Array = [
	[0,1,1,1,1,1,1,0],
	[1,1,0,0,0,0,1,1],
	[1,0,2,2,0,0,0,1],
	[1,0,1,0,0,0,0,1],
	[1,0,0,0,1,0,2,1],
	[1,1,1,1,1,1,1,1],
]

var blocks: Array = [
	Vector2(4,3), Vector2(5,3), Vector2(6,3)
]
var playerPos = Vector2(5,4)

static func pos(col: int, row: int) -> Vector2:
	return Padding + CellSize / 2 + (CellSize + Padding) * Vector2(col, row)
