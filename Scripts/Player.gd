
extends KinematicBody2D


const UP = Vector2(0,-1)
const GRAVITY = 20
const ACCELERATION = 20
const MAX_SPEED = 200
const JUMP_HEIGHT = -550

const FIREBALL = preload("res://Scenes/Fireball.tscn")

var motion = Vector2()
var is_attacking = false
var on_ground = false

var is_dead = false


func _physics_process(delta):
	if is_dead == false:
		motion.y += GRAVITY
		var friction = false
		
		if Input.is_action_pressed("ui_right"):
			if is_attacking == false || is_on_floor() ==false:
				motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
				if is_attacking == false:
					$Sprite.flip_h = false
					$Sprite.play("Run")
					if sign($Position2D.position.x) == -1:
						$Position2D.position.x *= -1
				
			
		elif Input.is_action_pressed("ui_left"):
			if is_attacking == false || is_on_floor() == false:
				motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
				if is_attacking == false:
					$Sprite.flip_h = true
					$Sprite.play("Run")
					if sign($Position2D.position.x) == 1:
							$Position2D.position.x *= -1
			
		else:
			if is_attacking == false && on_ground == true:
				$Sprite.play("Idle")
				friction = true
				motion.x = lerp(motion.x,0,0.2)
			
		if Input.is_action_just_pressed("ui_attack") && is_attacking == false:
			if is_on_floor():
				motion.x = 0
			is_attacking = true;
			$Sprite.play("Shoot")
			var fireball = FIREBALL.instance()
			if sign($Position2D.position.x) == 1:
				fireball.set_fireball_direction(1)
			else:
				fireball.set_fireball_direction(-1)
			get_parent().add_child(fireball)
			fireball.position = $Position2D.global_position
			
			
		
		if is_on_floor():
			if on_ground == false:
				is_attacking = false
			on_ground = true
	
			if Input.is_action_just_pressed("ui_up"):
				if on_ground == true:
					motion.y = JUMP_HEIGHT
					on_ground = false	
				if friction == true:
					motion.x = lerp(motion.x, 0, 0.2)
		else:
			on_ground = false
			if is_attacking == false:
				if motion.y < 0:
					$Sprite.play("Jump")
				else:
					$Sprite.play("Fall")
				if friction == true:
					motion.x = lerp(motion.x,0,0.05)

		motion = move_and_slide(motion,UP)
	else:
	
		motion.y += 60
		move_and_slide(motion,UP)
		$StaticBody2D.set_deferred("disabled", true)


func dead():
	is_dead = true
	$Sprite.play("Dead")
	$Timer.start()

func _on_Sprite_animation_finished():
	is_attacking = false
	

func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/TitleScreen.tscn")
