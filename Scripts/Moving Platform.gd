extends KinematicBody2D

export var move_speed =2.0
export var movie_distance = 50.0
export var move_direction = Vector2(1,1)
var time_since_init = 0.0
var origin = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	time_since_init = 0
	origin = position

func _physics_process(delta):
	time_since_init += delta
	var position_on_curve = sin(time_since_init * PI * move_speed)
	var offset = movie_distance * position_on_curve * move_direction
	position = origin + offset

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
