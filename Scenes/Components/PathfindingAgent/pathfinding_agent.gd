extends Node2D

var tilemap: TileMap
var path = [] 

var moving: bool = false
var is_facing_right: bool = true

signal agent_moving(is_moving: bool, facing_right: bool)

func _ready():
	pass

func move_to(target_position: Vector2):
	if moving:
		return

	path = Constants.astar_grid.get_id_path(
			tilemap.local_to_map(get_owner().global_position),
			tilemap.local_to_map(target_position))

	moving = true

	var current_point = path.pop_front()
	set_agent_moving(current_point)

	print(path)

func _process(_delta):
	if path.is_empty():
		moving = false
		agent_moving.emit(false, is_facing_right)
		return

	var next_position = tilemap.map_to_local(path.front())

	get_owner().global_position = get_owner().global_position.move_toward(next_position, 1)

	if get_owner().global_position == next_position:
		var current_point = path.pop_front()

		if not path.is_empty():
			set_agent_moving(current_point)

func set_agent_moving(current_point: Vector2):
	if current_point.x != path.front().x:
		is_facing_right = current_point.x < path.front().x
		
	agent_moving.emit(true, is_facing_right)
