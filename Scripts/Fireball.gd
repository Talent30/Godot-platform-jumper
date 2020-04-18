extends Area2D

const SPEED =200
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	velocity.x = SPEED * delta
	translate(velocity)
	$AnimatedSprite.play("shoot")
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

