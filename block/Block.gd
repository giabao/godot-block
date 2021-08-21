class_name Block
extends Movable

signal block_moved

# Vector2i
# require: g.canPushBlock(pos, d)
func move(d: Vector2) -> void:
	$StateMachine.transition_to("Moving", {direction = d})
	emit_signal("block_moved", pos, d)

func isMoving() -> bool:
	return $StateMachine.state.name == "Moving"