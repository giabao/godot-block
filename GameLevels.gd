class_name GameLevels

const levels := [
{   # 0. Values are in enum CellType
	map = [
		[1,1,1,1,1,0],
		[1,0,0,0,1,1],
		[1,2,0,2,0,1],
		[1,0,0,1,0,1],
		[1,0,0,0,0,1],
		[1,1,1,1,1,1],
	],
	blocks = [
		[2,2], [3,2]
	],
	player = [1,1]
},
{   # 1. Values are in enum CellType
	map = [
		[1,1,1,1,1,1,0],
		[1,0,0,0,0,1,1],
		[1,0,0,0,0,0,1],
		[1,0,1,2,0,2,1],
		[1,0,0,0,0,0,1],
		[1,1,1,1,1,1,1],
	],
	blocks = [
		[2,2], [3,2]
	],
	player = [1,1]
},
{   # 2. Values are in enum CellType
	map = [
		[0,0,1,1,1,1,0],
		[1,1,1,0,0,1,0],
		[1,0,0,2,0,1,1],
		[1,0,0,0,0,0,1],
		[1,0,1,2,0,0,1],
		[1,0,0,0,0,0,1],
		[1,1,1,1,1,1,1],
	],
	blocks = [
		[4,2], [4,3]
	],
	player = [1,2]
},
{   # 3. Values are in enum CellType
	map = [
		[0,1,1,1,1,1,0],
		[1,1,0,0,0,1,1],
		[1,0,0,1,0,0,1],
		[1,0,0,2,0,0,1],
		[1,0,0,2,0,0,1],
		[1,1,0,2,0,1,1],
		[0,1,1,1,1,1,0],
	],
	blocks = [
		[2,3], [3,3], [4,3]
	],
	player = [2,1]
},
{   # 4. Values are in enum CellType
	map = [
		[1,1,1,1,1,1,0,0],
		[1,0,0,0,0,1,1,1],
		[1,0,0,0,2,2,0,1],
		[1,0,0,0,0,0,0,1],
		[1,0,0,1,0,2,0,1],
		[1,1,1,1,1,1,1,1],
	],
	blocks = [
		[2,3], [3,3], [4,3]
	],
	player = [5,3]
},
{   # 5. Values are in enum CellType
	map = [
		[0,1,1,1,1,1,0,0],
		[1,1,0,0,0,1,1,1],
		[1,0,2,1,0,0,0,1],
		[1,0,0,1,0,1,0,1],
		[1,0,2,0,0,0,2,1],
		[1,0,0,0,0,1,1,1],
		[1,1,1,1,1,1,0,0],
	],
	blocks = [
		[2,4], [5,2], [5,4]
	],
	player = [6,2]
},
{   # 6. Values are in enum CellType
	map = [
		[0,1,1,1,1,1,1,0],
		[1,1,0,0,0,0,1,1],
		[1,0,2,2,0,0,0,1],
		[1,0,1,0,0,0,0,1],
		[1,0,0,0,1,0,2,1],
		[1,1,1,1,1,1,1,1],
	],
	blocks = [
		[4,3], [5,3], [6,3]
	],
	player = [5,4]
},
]

static func data(level: int) -> GameData:
	var g = GameData.new()
	var data = levels[level]
	g.map = data.map
	g.blocks = []
	for b in data.blocks:
		g.blocks += [Vector2(b[0], b[1])]
	g.playerPos = Vector2(data.player[0], data.player[1])

	g._mapRect = Rect2(Vector2.ZERO, Vector2(g.map[0].size(), g.map.size()))

	return g
