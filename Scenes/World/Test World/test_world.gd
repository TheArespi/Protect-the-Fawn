extends Node2D

@export var cell_size = Vector2i.ONE * Constants.tile_size

var grid_size

var start = Vector2i.ZERO
var end = Vector2i(5,5)

func _ready():
    initialize_grid()
    Constants.tilemap = $TileMap
    GlobalSignals.tilemap_initialized.emit()

func _draw():
    draw_rect(Rect2(start * cell_size, cell_size), Color.GREEN_YELLOW)
    draw_rect(Rect2(end * cell_size, cell_size), Color.ORANGE_RED)

func initialize_grid():
    grid_size = Vector2i(get_viewport_rect().size) / cell_size
    Constants.astar_grid.size = grid_size
    Constants.astar_grid.cell_size = cell_size
    Constants.astar_grid.offset = cell_size / 2
    Constants.astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
    Constants.astar_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_OCTILE
    Constants.astar_grid.update()

func update_path():
    $Line2D.points = PackedVector2Array(Constants.astar_grid.get_point_path(start, end))
    