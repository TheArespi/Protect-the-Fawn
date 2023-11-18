extends Node

#size of the tiles in the tilemap
@export var tile_size: int = 16

var tilemap
var tilemap_initialized = false

#pathfinding related
var astar_grid: AStarGrid2D

#direction
enum Directions {
    UP, 
    RIGHT,
    LEFT,
    DOWN
}

func _ready():
    astar_grid = AStarGrid2D.new()

func initialize_tilemap(tilemap_object: TileMap):
    tilemap = tilemap_object
    tilemap_initialized = true
    GlobalSignals.tilemap_initialized.emit()