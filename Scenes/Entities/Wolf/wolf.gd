extends Node2D

@export var tilemap: TileMap

var moving: bool = false
var current_fawn_location: Vector2 = position

var fawn_moved_while_wolf_walking: bool = false

func _ready():
	position = Util.snap_to_grid(position)
	$PathfindingAgent.tilemap = tilemap

	GlobalSignals.fawn_location_update.connect(fawn_location_changed)

func _process(_delta):
	if fawn_moved_while_wolf_walking:
		$PathfindingAgent.move_to(current_fawn_location)
		fawn_moved_while_wolf_walking = false
	
func _on_pathfinding_agent_agent_moving(is_moving: bool, facing_right: bool):
	moving = is_moving

	if is_moving:
		$AnimatedSprite2D.play("Wolf_Walking")
	else:
		$AnimatedSprite2D.play("Wolf_IDLE")

	if facing_right:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true

func fawn_location_changed(new_location: Vector2):
	print("Fawn Location Changed")
	current_fawn_location = new_location

	if moving:
		fawn_moved_while_wolf_walking = true
		return

	$PathfindingAgent.move_to(current_fawn_location)