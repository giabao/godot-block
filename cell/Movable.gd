class_name Movable
extends KinematicBody2D

# The following vars will be init in GameMap when create Block
var g: GameData
var pos: Vector2 # current pos Vector2i(col, row)

# must be called before add this block to scene
# pos: Vector2i
func init(_g: GameData, _pos: Vector2) -> Movable:
	g = _g
	pos = _pos
	return self
