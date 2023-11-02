extends Node2D

func _ready():
    position = position.snapped(Vector2.ONE * Constants.tile_size)
    position -= Vector2.ONE * Constants.tile_size / 2