extends Control

@onready var start_button: Button = $Control/ButtonManager/Start
@onready var quit_button: Button = $Control/ButtonManager/Quit

func _ready() -> void:
	quit_button.pressed.connect(on_quit)
	start_button.pressed.connect(on_start)

func on_start() -> void:
	get_tree().change_scene_to_file("res://nodes/game.tscn")

func on_quit() -> void:
	get_tree().quit()
