extends CanvasLayer

@onready var control: Control = $Control
@onready var resume_button: Button = $Control/VBoxContainer/ResumeButton
@onready var quit_button: Button = $Control/VBoxContainer/QuitButton

# process mode makes sure PauseMenu doesnt pause as well.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

	quit_button.pressed.connect(on_quit)
	resume_button.pressed.connect(on_resume)
	visible = false

# to exit out of the PauseMenu
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause() -> void:
	var pausing := not get_tree().paused
	get_tree().paused = pausing
	visible = pausing

func on_resume() -> void:
	toggle_pause()

func on_quit() -> void:
	toggle_pause()
	get_tree().change_scene_to_file("res://nodes/main_menu.tscn")
