extends Node2D

@export var speed: int = 16
@export var camera: Camera2D
@export var controllable: bool = false


func _ready():
	GlobalSignals.tilemap_initialized.connect(tilemap_initialized)

func _process(delta):
	if !Constants.tilemap_initialized:
		return 

	if controllable:
		var next_position: Vector2

		next_position = position

		if Input.is_action_pressed("move_up"):
			next_position.y -= speed * delta
		elif Input.is_action_pressed("move_down"):
			next_position.y += speed * delta

		if Input.is_action_pressed("move_right"):
			next_position.x += speed * delta
		elif Input.is_action_pressed("move_left"):
			next_position.x -= speed * delta

		position = next_position

func tilemap_initialized():
	print(Constants.tilemap)
	var map_limit = Constants.tilemap.get_used_rect()
	var map_cellsize = Constants.tilemap.tile_set.tile_size
	
	camera.limit_left = map_limit.position.x * map_cellsize.x
	camera.limit_right = map_limit.end.x * map_cellsize.x
	camera.limit_top = map_limit.position.y * map_cellsize.y
	camera.limit_bottom = map_limit.end.y * map_cellsize.y
