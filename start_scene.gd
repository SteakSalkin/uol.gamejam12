extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

const loading_scene_path = "res://loading_screen.tscn"
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file(loading_scene_path)
