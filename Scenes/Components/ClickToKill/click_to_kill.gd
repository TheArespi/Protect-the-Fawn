extends Node

@export var area_2d: Area2D
@export var sprite: AnimatedSprite2D

var is_mouse_hovering: bool = false

func _ready():
	area_2d.mouse_entered.connect(mouse_entered)
	area_2d.mouse_exited.connect(mouse_exited)

func _input(event):
	if not event.is_action_pressed("mouse_click"):
		return

	if not is_mouse_hovering:
		return

	GlobalSignals.monster_died.emit()
	get_owner().queue_free()

func mouse_entered():
	is_mouse_hovering = true
	sprite.modulate = Color.RED

func mouse_exited():
	is_mouse_hovering = false
	sprite.modulate = Color.WHITE
