extends CharacterBody2D

const SPEED = 500.0
@onready var icon = $Sprite2D

func _ready():
	icon.self_modulate = Color(1, 1, 1, 0)

func _physics_process(delta):
	var collision = move_and_collide(Vector2.LEFT * SPEED * delta)
	if collision:
		var collider = collision.get_collider() 
		if collider:
			Global.hp -= 1
			queue_free()
	icon.self_modulate += Color(0, 0, 0, 0.1 * delta)

func self_destroy():
	queue_free()
