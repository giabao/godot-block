class_name Movable
extends KinematicBody2D

# The following vars will be init in GameMap when create Block
var g: GameData
var pos: Vector2 # current pos Vector2i(col, row)

# must be called before add this block to scene
# pos: Vector2i
func init(g: GameData, pos: Vector2) -> Movable:
	self.g = g
	self.pos = pos
	return self
