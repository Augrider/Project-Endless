extends Button

func _ready() -> void:
	pressed.connect(Turns.pass_turn)
