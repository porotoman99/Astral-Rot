extends Edible


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if(body.get_class() == "CharacterBody2D"):
		play_sound()
		body.add_size(value)
		queue_free()


func play_sound():
	var sound_player = AudioStreamPlayer.new()
	sound_player.stream = load("res://assets/sfx/eat_metal.wav")
	sound_player.finished.connect(sound_player.queue_free)
	sound_player.bus = &"SFX"
	get_parent().add_child(sound_player)
	sound_player.play()
