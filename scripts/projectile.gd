extends CharacterBody2D


const SPEED = 800.0

func _physics_process(delta):
	var collision = move_and_collide(Vector2.RIGHT * SPEED * delta)
	if collision:
		var collider = collision.get_collider() 
		if collider:
			if collider.has_method("self_destroy"):
				collider.self_destroy()
				Global.points += 100
			queue_free()


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
