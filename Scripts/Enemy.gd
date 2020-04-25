extends KinematicBody2D

onready var Player = get_parent().get_node("Player")
const GRAVITY = 20
export (int) var speed = 150
export (int) var hp = 1
const FLOOR = Vector2(0,-1)
const JUMP_HEIGHT = -600
var velocity = Vector2()

var react_time = 350
var dir = 0
var next_dir = 0
var next_dir_time = 0
var target_player_dist = 60
var kill_player_dist = 40
#direction on the right
var next_jump_time = -1
var is_dead = false
var see_player = false
var target = null
var  direction = 1 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func dead():
	hp -= get_node("/root/MainHUD").power
	if hp <= 0:
		is_dead = true
		velocity = Vector2(0,0)
		$AnimatedSprite.play("Dead")
		#$CollisionPolygon2D.disabled = true // does not work for 3.1
		$Timer.start()

func set_dir(targets_dir):
	if next_dir != targets_dir:
		next_dir = targets_dir
		next_dir_time = OS.get_ticks_msec() + react_time
		
func _physics_process(delta):
			
	if is_dead == false:
		if see_player:
			if Player.position.x < position.x -target_player_dist and see_player == true:
				set_dir(-1)
				$AnimatedSprite.flip_h = true
				if Player.position.x + 65 > position.x:
					$AnimatedSprite.play("Attack")
				else:
					$AnimatedSprite.play("Walk")
				if is_on_wall():
					velocity.y = JUMP_HEIGHT
			
			elif Player.position.x > position.x -target_player_dist and see_player == true:
				set_dir(1)
				$AnimatedSprite.flip_h = false
				if Player.position.x - 65 < position.x:
					$AnimatedSprite.play("Attack")
				else:
					$AnimatedSprite.play("Walk")
				if is_on_wall():
					velocity.y = JUMP_HEIGHT
	
			
			if OS.get_ticks_msec() > next_dir_time:
				dir = next_dir
	
			
			if OS.get_ticks_msec() > next_jump_time && next_jump_time != -1:
				if Player.position.y < position.y -32:
					velocity.y = JUMP_HEIGHT
				next_jump_time = -1
			velocity.x = dir * speed
			
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
		else:
			velocity.x = speed * direction
		
			if direction == 1:
				$AnimatedSprite.flip_h = false
			else:
				$AnimatedSprite.flip_h = true
		
			$AnimatedSprite.play("Walk")
			
			velocity.y += GRAVITY
		
			velocity = move_and_slide(velocity, FLOOR)
		
		
			if is_on_wall():
				direction = direction * -1
				$RayCast2D.position.x *= -1
			#dectect the edge of the floor
			if $RayCast2D.is_colliding() == false:
				direction = direction * -1
				$RayCast2D.position.x *= -1


func _on_Timer_timeout():
	queue_free()



func _on_Area2D_body_entered(_body):
	see_player = true
	$AnimatedSprite.play("Attack")



func _on_Area2D_body_exited(_body):
	see_player = false
