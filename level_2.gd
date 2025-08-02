extends Node2D

@onready var edibles = $Edibles
@onready var level_end = false
@onready var ending_timer = $EndingTimer
@onready var player = $Player
signal ending

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(edibles.get_child_count() == 0 and level_end == false):
		level_end = true
		player.fade_out()
		ending_timer.start()


func next_level():
	ending.emit()
