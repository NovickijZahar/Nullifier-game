extends Node2D

var length = 50
var start_pos: Vector2
var cur_pos: Vector2
var swiping = false
var threshold = 10
@onready var player = $Player
@onready var hp = $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/TextureRect/Label
@onready var points = $CanvasLayer/MarginContainer/VBoxContainer/HBoxContainer/Label2

var player_position = [Vector2(200, 200), Vector2(200, 500), Vector2(200, 800)]
var current_player_position = 1
var enemy_position = [Vector2(1800, 200), Vector2(1800, 500), Vector2(1800, 500)]

var enemies = [preload("res://scenes/shadow_blade.tscn"), preload("res://scenes/ethereal.tscn")]

var PROJECTILE_SCENE = preload("res://scenes/projectile.tscn")

func _ready():
	player.position = player_position[current_player_position]
	spawn_enemy()

func _on_touch_screen_button_pressed():
	start_pos = get_global_mouse_position()

func _on_touch_screen_button_released():
	cur_pos = get_global_mouse_position()
	if start_pos.distance_to(cur_pos) >= length:
		if (start_pos.y - cur_pos.y) > 0:
			if current_player_position != 0:
				player.position -= Vector2(0, 300)
				current_player_position -= 1
		elif (cur_pos.y - start_pos.y) > 0:
			if current_player_position != 2:
				player.position += Vector2(0, 300)
				current_player_position += 1
	else:
		shot()


func shot():
	var projectile = PROJECTILE_SCENE.instantiate()
	projectile.position = player.position + Vector2(200, 0)
	player.add_child(projectile)



func _process(delta):
	hp.text = str(Global.hp)
	points.text = str(Global.points)
	if Global.hp <= 0:
		Global.hp = Global.MAX_HP
		Global.points = 0
		get_tree().change_scene_to_file("res://scenes/menu.tscn")


func spawn_enemy():
	var enemy = enemies.pick_random().instantiate()
	enemy.position = enemy_position.pick_random()
	add_child(enemy)

func _on_timer_timeout():
	spawn_enemy()
