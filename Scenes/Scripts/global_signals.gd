extends Node

signal fawn_movement_update(is_moving: bool)
signal fawn_location_update(current_location: Vector2)
signal tilemap_initialized()
signal monster_died()
signal fawn_died()

var fawn_location: Vector2