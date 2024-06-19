extends Node2D

var length = 50
var start_pos: Vector2
var cur_pos: Vector2
var swiping = false
var threshold = 10
@onready var player = $Player
@onready var hp = $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/TextureRect/Label

var PROJECTILE_SCENE = preload("res://scenes/projectile.tscn")


func _on_touch_screen_button_pressed():
	start_pos = get_global_mouse_position()

func _on_touch_screen_button_released():
	cur_pos = get_global_mouse_position()
	if start_pos.distance_to(cur_pos) >= length:
		if (start_pos.y - cur_pos.y) > 0:
			player.position -= Vector2(0, 300)
		elif (cur_pos.y - start_pos.y) > 0:
			player.position += Vector2(0, 300)
	else:
		shot()


func shot():
	var projectile = PROJECTILE_SCENE.instantiate()
	projectile.position = player.position + Vector2(200, 0)
	player.add_child(projectile)



func _process(delta):
	hp.text = str(Global.hp)
	if Global.hp <= 0:
		Global.hp = Global.MAX_HP
		Global.points = 0
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
