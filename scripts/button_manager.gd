extends Control

@onready var play_btn: Button = $Start
@onready var quit_btn: Button = $Quit

const hover_scale = Vector2(1.08, 1.08)
const hover_tilt = 4.0

var _tweens: Dictionary = {}

# Connects all the child nodes to the animation
func _ready() -> void:
	await get_tree().process_frame
	var i = 0
	for child in get_children():
		if child is Button:
			wire(child, i)
			i += 1

func wire(btn: Button, index: int) -> void:
	btn.pivot_offset = btn.size/2.0
	var tilt = 1.0 if index % 2 == 0 else -1.0

	btn.mouse_entered.connect(on_hover.bind(btn, true, tilt))
	btn.mouse_exited.connect(on_hover.bind(btn, false, tilt))

func on_hover(btn: Button, entering: bool, tilt_dir: float) -> void:
	var tween = create_tween().set_parallel(true)
	_tweens[btn] = tween
	tween.tween_property(btn, "scale", hover_scale if entering else Vector2.ONE, 0.15)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(btn, "rotation_degrees", hover_tilt * tilt_dir if entering else 0.0, 0.15)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
