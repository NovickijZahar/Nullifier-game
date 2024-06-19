extends Node2D


func _ready():
	pass


func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_button_2_pressed():
	pass


func _on_button_3_pressed():
	get_tree().quit()
