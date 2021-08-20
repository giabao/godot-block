class_name GameMap
extends Node2D

const G = preload("GameData.gd")
var g = G.new()

const BrickScene  = preload("res://cell/Brick.tscn")
const BlockScene  = preload("res://cell/Block.tscn")
const TargetScene = preload("res://cell/Target.tscn")
const PlayerScene = preload("res://player/player.tscn") 

func _ready():
	for row in g.map.size():
		for col in g.map[row].size():
			var cell: Node2D
			match g.map[row][col]:
				G.CellType.Brick:
					cell = BrickScene.instance()
				G.CellType.Block:
					cell = BlockScene.instance().init(g, col, row)
				G.CellType.Target:
					cell = TargetScene.instance()
				G.CellType.Player:
					cell = PlayerScene.instance()
				_:  cell = null
			
			if cell != null:
				cell.position = GameData.pos(col, row)
				add_child(cell)
				cell.owner = self
