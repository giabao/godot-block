class_name PlayerIdle
extends PlayerState

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
	player.animate(Vector2.ZERO)

func handle_input(e):
	var d := Player.direction_from_input()
	player.animate(d)
	
	if d != Vector2.ZERO:
		print("_input: %s" % e)
		if g.canMovePlayer(player.pos, d):
			state_machine.transition_to("Moving", {direction = d})
