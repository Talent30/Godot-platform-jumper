extends KinematicBody2D


const UP = Vector2(0,-1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -550

const FIREBALL =preload("res://Scenes/Fireball.tscn")

var motion = Vector2()

var is_attacking = false

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false
		$Sprite.play("Run")
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
			
		
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true
		$Sprite.play("Run")
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	else:
		$Sprite.play("Idle")
		friction = true
		motion.x = lerp(motion.x,0,0.2)
		
	if Input.is_action_pressed("ui_focus_next"):
		$Sprite.play("Shoot")
		var fireball = FIREBALL.instance()

		#flip the fireball direction
		if sign($Position2D.position.x) == 1:
			fireball.set_fireball_direction(1)
		else:
			fireball.set_fireball_direction(-1)
		

		get_parent().add_child(fireball)
		fireball.position = $Position2D.global_position
		
		
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y <0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Fall")
		if friction == true:
			motion.x = lerp(motion.x,0,0.05)
	motion = move_and_slide(motion,UP)
	pass
