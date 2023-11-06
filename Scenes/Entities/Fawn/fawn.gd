extends Node2D

var moving: bool = false

enum FawnStates {
	IDLE,
	WANDERING,
	SITTING,
	SLEEPING,
	STANDING,
}

var fawn_state_label = {
	FawnStates.IDLE: "IDLE",
	FawnStates.WANDERING: "Wandering",
	FawnStates.SITTING: "Sitting",
	FawnStates.SLEEPING: "Sleeping",
	FawnStates.STANDING: "Standing",
}

var current_state: FawnStates = FawnStates.IDLE :
	set(value):
		current_state = value
		print("Current Fawn State: ", fawn_state_label[current_state])
	get:
		return current_state

var is_sleeping: bool = false
var is_woken_up: bool = false
var is_tilemap_initialized: bool = false

func _ready():
	position = Util.snap_to_grid(position)
	GlobalSignals.tilemap_initialized.connect(initialize_tilemap)
	GlobalSignals.fawn_location = global_position

func _process(_delta):
	if not is_tilemap_initialized:
		return

	if current_state == FawnStates.IDLE:
		if $IDLETimer.is_stopped():
			$IDLETimer.start()
	elif current_state == FawnStates.WANDERING:
		if not moving:
			move_to_random_area()
	elif current_state == FawnStates.SITTING:
		if $AnimatedSprite2D.animation != "Fawn_Sitting":
			$AnimatedSprite2D.play("Fawn_Sitting")
		else:
			if not $AnimatedSprite2D.is_playing():
				current_state = FawnStates.SLEEPING
	elif current_state == FawnStates.SLEEPING:
		#later on make this that when the fawn detects danger it would move to another place
		if not is_sleeping:
			$AnimatedSprite2D.play("Fawn_Sleeping")
			$SleepTimer.start()
			is_sleeping = true
			is_woken_up = false
			print("is_woken_up: ", is_woken_up)
		else:
			if is_woken_up:
				current_state = FawnStates.STANDING
	elif current_state == FawnStates.STANDING:
		if $AnimatedSprite2D.animation != "Fawn_Standing":
			is_sleeping = false
			$AnimatedSprite2D.play("Fawn_Standing")
		else:
			if not $AnimatedSprite2D.is_playing():
				$AnimatedSprite2D.play("Fawn_IDLE")
				choose_random_state()
		

func _on_pathfinding_agent_agent_moving(is_moving: bool, facing_right: bool):
	print("agent moving: ", is_moving, "facing right: ", facing_right)
	if moving != is_moving:
		GlobalSignals.fawn_movement_update.emit(is_moving)

	if not is_moving:
		GlobalSignals.fawn_location_update.emit(global_position)
		GlobalSignals.fawn_location = global_position
		choose_random_state()

	moving = is_moving

	if is_moving:
		$AnimatedSprite2D.play("Fawn_Walking")
	else:
		$AnimatedSprite2D.play("Fawn_IDLE")

	if facing_right:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true

func move_to_random_area():
	var tilemap_rect = Constants.tilemap.get_used_rect()

	print("tilemap position: ", tilemap_rect.position, " tilemap size: ", tilemap_rect.size, " tileset tilesize: ", Constants.tilemap.tile_set.tile_size)

	var random_x = randi() % int(tilemap_rect.size.x * Constants.tilemap.tile_set.tile_size.x) + tilemap_rect.position.x
	var random_y = randi() % int(tilemap_rect.size.y * Constants.tilemap.tile_set.tile_size.y) + tilemap_rect.position.y

	var new_target = Vector2(random_x, random_y)

	print("Fawn's new target: ", new_target)
	$PathfindingAgent.move_to(new_target)

func _on_idle_timer_timeout():
	print("timer done")
	choose_random_state()

func choose_random_state():
	var state_pool = [FawnStates.IDLE, FawnStates.SITTING, FawnStates.WANDERING]

	if state_pool.has(FawnStates.WANDERING):
		if current_state == FawnStates.STANDING:
			state_pool.erase(FawnStates.SITTING)
		else:
			state_pool.erase(current_state)

	current_state = state_pool[randi() % len(state_pool)]

func _on_sleep_timer_timeout():
	is_woken_up = true
	print("is_woken_up: ", is_woken_up)

func initialize_tilemap():
	is_tilemap_initialized = true
