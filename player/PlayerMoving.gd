class_name PlayerMoving
extends PlayerState

var direction: Vector2

func enter(msg := {}) -> void:
	direction = msg.direction
	assert(direction != Vector2.ZERO)
	player.animate(direction)
				
func physics_update(_delta: float) -> void:
	var nextPosition = GameData.pos(player.pos + direction)
	if GameData.reached(player, direction, nextPosition):
		print("%s reached: %s -> %s" % [player.name, player.position, nextPosition])
		player.pos += direction
		player.position = nextPosition
		if player.direction_from_input() != Vector2.ZERO && g.canMovePlayer(player.pos, direction):
			state_machine.transition_to("Moving", {direction = direction})
		else:
			state_machine.transition_to("Idle")
		return
	
	player.move_and_slide(player.speed * direction)
	if player.get_slide_count() > 0:
		var b := player.get_slide_collision(0).collider as Block
		if b && !b.isMoving() && g.canPushBlock(b.pos, direction):
			b.move(direction)
		# else: TODO sound ""

