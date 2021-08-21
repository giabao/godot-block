class_name GameMap
extends Node2D

const BrickScene  = preload("res://cell/Brick.tscn")
const TargetScene = preload("res://cell/Target.tscn")
const BlockScene  = preload("res://block/Block.tscn")
const PlayerScene = preload("res://player/player.tscn") 

const CellType = GameData.CellType
var g = GameData.new()

var targetCount = g.countTargets()
var targetMatched: int = g.countMatchedTargets()

# pos: Vector2i(col, row)
func _addCell(cell: Node2D, pos: Vector2):
	cell.position = GameData.pos(pos)
	add_child(cell)
	cell.owner = self

func _ready():
	var cell: Node2D
	for row in g.map.size():
		for col in g.map[row].size():
			match g.map[row][col]:
				CellType.Brick: cell = BrickScene.instance()
				CellType.Target: cell = TargetScene.instance()
				_: cell = null
			
			if cell != null:
				_addCell(cell, Vector2(col, row))
	
	for p in g.blocks:
		cell = BlockScene.instance().init(g, p)
		cell.connect("block_moved", self, "_on_block_moved")
		_addCell(cell, p)
	
	cell = PlayerScene.instance().init(g, g.playerPos)
	_addCell(cell, g.playerPos)


func _on_block_moved(prevPos: Vector2, direction: Vector2):
	print("_on_block_moved %s -> %s" % [prevPos, direction])

	targetMatched += g.countTargetAt(prevPos + direction) - g.countTargetAt(prevPos)
	var i = g.blocks.find(prevPos)
	assert(i != -1)
	g.blocks[i] = prevPos + direction

	if targetMatched == targetCount:
		print("Yeah! You win!")
