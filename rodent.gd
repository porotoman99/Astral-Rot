extends Edible
@onready var area2d = $"."


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if(body.get_class() == "CharacterBody2D" and "balls" in body):
		play_sound()
		body.add_size(value)
		if(Config.blood and bleeds):
			var level = area2d.get_parent().get_parent()
			var bloodScene = ResourceLoader.load("res://blood.tscn")
			for i in range(50):
				var blood = bloodScene.instantiate()
				blood.rotation_degrees = randf_range(0, 360)
				blood.global_position.x = area2d.global_position.x + randf_range(-50, 50)
				blood.global_position.y = area2d.global_position.y + randf_range(-50, 50)
				blood.z_index = -1
				level.add_child(blood)
		queue_free()


func play_sound():
	var sound_player = AudioStreamPlayer.new()
	sound_player.stream = load("res://assets/sfx/eat_rodent.wav")
	sound_player.finished.connect(sound_player.queue_free)
	sound_player.bus = &"SFX"
	get_parent().add_child(sound_player)
	sound_player.play()
