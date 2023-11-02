extends Node2D

@export var tilemap: TileMap

func _ready():
    position = Util.snap_to_grid(position)
    $PathfindingAgent.tilemap = tilemap