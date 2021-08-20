class_name GameMap
extends Node2D

const BrickScene  = preload("res://cell/Brick.tscn")
const BlockScene  = preload("res://cell/Block.tscn")
const TargetScene = preload("res://cell/Target.tscn")
const PlayerScene = preload("res://player/player.tscn") 

const CellType = GameData.CellType
var g = GameData.new()

func _countTargets() -> int:
	var ret := 0
	for row in g.map:
		ret += row.count(CellType.Target)
	return ret

var targetCount = _countTargets()
var targetMatched := 0

func _addCell(cell: Node2D, col: int, row: int):
	cell.position = GameData.pos(col, row)
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
				_addCell(cell, col, row)
	
	for p in g.blocks:
		cell = BlockScene.instance().init(g, p.x, p.y)
		cell.connect("block_match_changed", self, "_on_block_match_changed")
		_addCell(cell, p.x, p.y)
	
	_addCell(PlayerScene.instance(), g.playerPos.x, g.playerPos.y)


func _on_block_match_changed(changed: int):
	print("block_match_changed %s" % changed)
	targetMatched += changed
	if targetMatched == targetCount:
		print("Yeah! You win!")
