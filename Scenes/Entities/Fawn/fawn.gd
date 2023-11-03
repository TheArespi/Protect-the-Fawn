extends Node2D

@export var tilemap: TileMap

var moving: bool = false

func _ready():
	position = Util.snap_to_grid(position)
	$PathfindingAgent.tilemap = tilemap

	move_to_random_area()

func _on_pathfinding_agent_agent_moving(is_moving: bool, facing_right: bool):
	print("agent moving: ", is_moving, "facing right: ", facing_right)
	if moving != is_moving:
		GlobalSignals.fawn_movement_update.emit(is_moving)

	if not is_moving:
		GlobalSignals.fawn_location_update.emit(global_position)
		$IDLETimer.start()

	moving = is_moving

	if is_moving:
		$AnimatedSprite2D.play("Fawn_Walking")
	else:
		$AnimatedSprite2D.play("Fawn_IDLE")

	if facing_right:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true

func move_to_random_area():
	var tilemap_rect = tilemap.get_used_rect()

	print("tilemap position: ", tilemap_rect.position, " tilemap size: ", tilemap_rect.size, " tileset tilesize: ", tilemap.tile_set.tile_size)

	var random_x = randi() % int(tilemap_rect.size.x * tilemap.tile_set.tile_size.x) + tilemap_rect.position.x
	var random_y = randi() % int(tilemap_rect.size.y * tilemap.tile_set.tile_size.y) + tilemap_rect.position.y

	var new_target = Vector2(random_x, random_y)

	print("Fawn's new target: ", new_target)
	$PathfindingAgent.move_to(new_target)

func _on_idle_timer_timeout():
	print("timer done")
	move_to_random_area()
