extends CharacterBody2D

@onready var timer = $Timer
var PROJECTILE_SCENE = preload("res://scenes/etherial_projectile.tscn")
const SPEED = 300.0

func _ready():
	timer.wait_time = randf_range(0.5, 2)
	timer.start()

func _physics_process(delta):
	var collision = move_and_collide(Vector2.LEFT * SPEED * delta)
	if collision:
		var collider = collision.get_collider() 
		if collider:
			Global.hp -= 1
			queue_free()

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

func _on_timer_timeout():
	shot()
	timer.wait_time = randf_range(0.5, 2)
	timer.start()
	 
func shot():
	var projectile = PROJECTILE_SCENE.instantiate()
	projectile.position = position - Vector2(250, 0)
	get_parent().add_child(projectile)

func self_destroy():
	queue_free()

