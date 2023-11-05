extends Node

#size of the tiles in the tilemap
var tile_size: int = 16
var tilemap: TileMap

#pathfinding related
var astar_grid: AStarGrid2D = AStarGrid2D.new()

#direction
enum Directions {
    UP, 
    RIGHT,
    LEFT,
    DOWN
}