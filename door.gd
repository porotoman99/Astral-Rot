extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var detector = $Detector
@onready var open = false
signal opened

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(open and len(detector.get_overlapping_bodies().filter(func(b): return b is CharacterBody2D)) == 0 and animation_player.is_playing() == false):
		open = false
		play_sound()
		animation_player.play("door_open", -1, -1, true)


func _on_detector_body_entered(body):
	if(open == false and body is not StaticBody2D):
		open = true
		play_sound()
		opened.emit()
		animation_player.play("door_open")


func play_sound():
	var sound_player = AudioStreamPlayer.new()
	sound_player.stream = load("res://assets/sfx/door.wav")
	sound_player.finished.connect(sound_player.queue_free)
	sound_player.bus = &"SFX"
	get_parent().add_child(sound_player)
	sound_player.play()
