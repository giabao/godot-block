class_name PlayerIdle
extends PlayerState

# Upon entering the state, we set the Player node's velocity to zero.
func enter(_msg := {}) -> void:
    player.animate(Vector2.ZERO)

func handle_input(e):
    player.calc_next_direction(e)
    player.animate(player.next_direction)

    if ! (e is InputEventMouseMotion || e is InputEventScreenDrag):
        print("_input: %s" % e)
    
    if player.next_direction != Vector2.ZERO:
        if g.canMovePlayer(player.pos, player.next_direction):
            state_machine.transition_to("Moving", {direction = player.next_direction})
        else:
            player.next_direction = Vector2.ZERO
