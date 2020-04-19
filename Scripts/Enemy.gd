extends KinematicBody2D

onready var Player = get_parent().get_node("Player")
const GRAVITY = 20
const SPEED = 180
const FLOOR = Vector2(0,-1)
const JUMP_HEIGHT = -600
var velocity = Vector2()

var react_time = 300
var dir = 0
var next_dir = 0
var next_dir_time = 0
var target_player_dist = 60
#direction on the right
var  direction = 1 
var next_jump_time = -1
var eye_reach = 90
var vision = 300
var is_dead = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("Dead")
	$CollisionPolygon2D.set_deferred("disabled", true)
	#$CollisionPolygon2D.disabled = true // does not work for 3.1
	$Timer.start()

func set_dir(targets_dir):
	if next_dir != targets_dir:
		next_dir = targets_dir
		next_dir_time = OS.get_ticks_msec() + react_time

func sees_player():
	var eye_center = get_global_position()
	var eye_top = eye_center + Vector2(0, -eye_reach)
	var eye_left = eye_center + Vector2(-eye_reach, 0)
	var eye_right = eye_center + Vector2(eye_reach, 0)
		
	var player_pos = Player.get_global_position()
	var player_extents =  Vector2(14,28) - Vector2(1,1)
	var top_left = player_pos + Vector2(-player_extents.x, -player_extents.y)
	var top_right = player_pos + Vector2(player_extents.x, -player_extents.y)
	var bottom_left = player_pos + Vector2(-player_extents.x, player_extents.y)
	var bottom_right = player_pos + Vector2(player_extents.x, player_extents.y)
		
	var space_state = get_world_2d().direct_space_state
		
	for eye in [eye_center, eye_top, eye_left, eye_right]:
		for corner in [top_left, top_right, bottom_left, bottom_right]:
			if (corner - eye).length() > vision:
				continue
			var collision = space_state.intersect_ray(eye, corner, [], 1) # collision mask = sum of 2^(collision layers) - e.g 2^0 + 2^3 = 9
			if collision and collision.collider.name == "Player":
					return true
	return false		
		
func _physics_process(delta):
	if is_dead == false:
		print(sees_player())
		
		if Player.position.x < position.x -target_player_dist && sees_player():
			set_dir(-1)
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("Walk")
		elif Player.position.x > position.x +target_player_dist && sees_player():
			set_dir(1)
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("Walk")
		else:
			set_dir(0)
			$AnimatedSprite.play("Attack")
		
		if OS.get_ticks_msec() > next_dir_time:
			dir = next_dir
		
		if OS.get_ticks_msec() > next_jump_time && next_jump_time != -1:
			if Player.position.y < position.y -64:
				velocity.y = JUMP_HEIGHT
			next_jump_time = -1
	
		velocity.x = dir * SPEED
		
		if Player.position.y < position.y -64 and is_on_floor() && next_jump_time == -1:
			next_jump_time = OS.get_ticks_msec() +react_time
			
		velocity.y += GRAVITY
		if is_on_floor():
			velocity.y = 0
	
	velocity = move_and_slide(velocity, FLOOR)
			#get collison 
	if get_slide_count() > 0:
		for i in range(get_slide_count()):
			if "Player" in get_slide_collision(i).collider.name:
				get_slide_collision(i).collider.dead()


func _on_Timer_timeout():
	queue_free()

