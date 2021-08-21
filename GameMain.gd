extends Node2D

const GameMapScene  = preload("res://GameMap.tscn")

var level = 0
var gameMap: GameMap

func _ready():
	get_node("GUI/tools/Reset").connect("pressed", self, "_on_reset")
	# get_node("GUI/tools/Setting").connect("pressed", self, "_on_setting")
	# get_node("GUI/tools/Back").connect("pressed", self, "_on_back")

	gameMap = $GameMap.init(GameLevels.data(level))
	gameMap.connect("completed_level", self, "_on_completed_level")

func _addGameMap():
	var data = GameLevels.data(level)
	gameMap = GameMapScene.instance().init(data)
	add_child(gameMap)
	gameMap.connect("completed_level", self, "_on_completed_level")

func _on_completed_level():
	print("Ohze! You win level %s" % level)
	if level >= GameLevels.levels.size():
		print("You have win all levels!")
	else:
		_changeLevel(level + 1)

func _changeLevel(level: int):
	remove_child(gameMap)
	gameMap.queue_free()
	self.level = level
	_addGameMap()

func _on_reset():
	remove_child(gameMap)
	gameMap.queue_free()
	_addGameMap()

func _on_setting():
	pass

func _on_back():
	pass
