extends Node2D

@export var camera_speed: float = 32.0

var is_pressing_mouse: bool = false
var previous_mouse_position: Vector2 = Vector2.ZERO

var is_pressing = {
	Constants.Directions.UP: false,
	Constants.Directions.RIGHT: false,
	Constants.Directions.LEFT: false,
	Constants.Directions.DOWN: false,
}

func _ready():
	GlobalSignals.tilemap_initialized.connect(tilemap_initialized)

func tilemap_initialized():
	var map_limit = Constants.tilemap.get_used_rect()
	var map_cellsize = Constants.tilemap.tile_set.tile_size
	
	$Camera2D.limit_left = map_limit.position.x * map_cellsize.x
	$Camera2D.limit_right = map_limit.end.x * map_cellsize.x
	$Camera2D.limit_top = map_limit.position.y * map_cellsize.y
	$Camera2D.limit_bottom = map_limit.end.y * map_cellsize.y
