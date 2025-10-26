extends Node2D

const REMAINING_TIME = 200

var remaining_time = REMAINING_TIME

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Winning massage/Player 1 Won".hide()
	$"Winning massage/Player 2 Won".hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if remaining_time > 1:
		remaining_time -= 1 * delta
	else:
		remaining_time = 0
		if ($"Winning massage/Player 2 Won".visible == false and $"Winning massage/Player 1 Won".visible == false):
			get_node("/root/level/Player").get_damage(1000)
	$"Remaining Time".text = str(int(remaining_time)) + " Sekunden Verbleiben"

func player_1_wins() -> void:
	$"Winning massage/Player 1 Won".show()

func player_2_wins() -> void:
	$"Winning massage/Player 2 Won".show()
