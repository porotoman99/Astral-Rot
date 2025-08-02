extends Edible
@onready var laser = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	laser.position.x += 1000.0 * cos(laser.rotation) * delta
	laser.position.y += 1000.0 * sin(laser.rotation) * delta


func _on_body_entered(body):
	if(body.get_class() == "CharacterBody2D"):
		play_sound()
		body.lose_size(1)
		queue_free()
	elif(body.get_class() == "StaticBody2D"):
		queue_free()


func play_sound():
	var sound_player = AudioStreamPlayer.new()
	sound_player.stream = load("res://assets/sfx/hit.wav")
	sound_player.finished.connect(sound_player.queue_free)
	sound_player.bus = &"SFX"
	get_parent().add_child(sound_player)
	sound_player.play()
