extends Node2D

@export var tilemap: TileMap

func _ready():
	position = Util.snap_to_grid(position)
	$PathfindingAgent.tilemap = tilemap

func _on_pathfinding_agent_agent_moving(is_moving: bool, facing_right: bool):
	if is_moving:
		$AnimatedSprite2D.play("Fawn_Walking")
	else:
		$AnimatedSprite2D.play("Fawn_IDLE")

	if facing_right:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true