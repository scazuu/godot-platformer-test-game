extends Area2D

@onready var timer: Timer = $Timer
const KNOCK_UP = -200

func _on_body_entered(_body):
	print("Died")
	_body.IS_DEAD = true
	Engine.time_scale = 0.5
	_body.get_node("CollisionShape2D").queue_free()
	_body.velocity.y = KNOCK_UP
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
