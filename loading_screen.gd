extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ Path2D/PathFollow2D/Zahnrad.rotate( 2 * delta)


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://level/level.tscn")
