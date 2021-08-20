class_name GameData

enum CellType {
	None, Brick, Block, Target, Player
}

const CellSize = Vector2(64, 64)
const Padding = Vector2(1, 1)

# Values are in enum CellType
var map: Array = [
	[0,1,1,1,1,1,1,0],
	[1,1,0,0,0,0,1,1],
	[1,0,3,3,0,0,0,1],
	[1,0,1,0,2,2,2,1],
	[1,0,0,0,1,4,3,1],
	[1,1,1,1,1,1,1,1],
]

static func pos(col: int, row: int) -> Vector2:
	return Padding + CellSize / 2 + (CellSize + Padding) * Vector2(col, row)
