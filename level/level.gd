extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Winning massage/Player 1 Won".hide()
	$"Winning massage/Player 2 Won".hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func player_1_wins() -> void:
	$"Winning massage/Player 1 Won".show()

func player_2_wins() -> void:
	$"Winning massage/Player 2 Won".show()
