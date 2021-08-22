class_name Block
extends Movable

signal block_moved(pos, direction)

# Vector2i
# require: g.canPushBlock(pos, d)
func move(d: Vector2) -> void:
	$StateMachine.transition_to("Moving", {direction = d})
	emit_signal("block_moved", pos, d)

func isMoving() -> bool:
	return $StateMachine.state.name == "Moving"

func _ready():
    $matched.visible = g.countTargetAt(pos)
    $StateMachine.connect("transitioned", self, "_on_transitioned")

func _on_transitioned(state_name: String) -> void:
    $matched.visible = g.countTargetAt(pos)