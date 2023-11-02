extends Node

func snap_to_grid(entity_position: Vector2):
    entity_position = entity_position.snapped(Vector2.ONE * Constants.tile_size)
    entity_position -= Vector2.ONE * Constants.tile_size / 2
    return entity_position