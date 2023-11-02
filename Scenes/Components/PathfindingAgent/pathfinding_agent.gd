extends Node2D

var target_position: Vector2
var tilemap: TileMap
var path = [] 

var moving: bool = false

func _ready():
	pass

func _input(event):
	if event.is_action_pressed("mouse_click") == false or moving:
		return

	print("Player Position: ", get_owner().global_position, " local_to_map: ", tilemap.local_to_map(get_owner().global_position))
	print("Mouse Position: ", get_owner().get_global_mouse_position(), " local_to_map: ", tilemap.local_to_map(get_owner().get_global_mouse_position()))

	path = Constants.astar_grid.get_id_path(
			tilemap.local_to_map(get_owner().global_position),
			tilemap.local_to_map(get_owner().get_global_mouse_position())).slice(1)

	moving = true
	print(path)

func _process(_delta):
	if path.is_empty():
		moving = false
		return

	var next_position = tilemap.map_to_local(path.front())

	get_owner().global_position = get_owner().global_position.move_toward(next_position, 1)

	if get_owner().global_position == next_position:
		path.pop_front()
