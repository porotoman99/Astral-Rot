extends Edible

@onready var rot_speed = randf_range(-2.0, 2.0)
@onready var area2d = $"."
@onready var sprite_2d = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var sprites = [
		"res://assets/hull_triangle.png",
		"res://assets/hull_square.png"
	]
	sprite_2d.texture = load(sprites[randi_range(0,1)])
	area2d.rotation = randf_range(0,360)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	area2d.rotation += rot_speed * delta


func _on_body_entered(body):
	if(body.get_class() == "CharacterBody2D"):
		#play_sound()
		body.add_size(value)
		queue_free()


func play_sound():
	var sound_player = AudioStreamPlayer.new()
	sound_player.stream = load("res://assets/sfx/eat_metal.wav")
	sound_player.finished.connect(sound_player.queue_free)
	sound_player.bus = &"SFX"
	get_parent().add_child(sound_player)
	sound_player.play()
