extends CharacterBody2D

@onready var area2d = $Area2D
@onready var value = 1.0
@onready var bleeds = true
@onready var alert = false
@onready var fire_timer = $FireTimer
@onready var target = null
@onready var human = $"."
@onready var laser_spot = $LaserSpot

func _ready():
	fire_timer.wait_time = randf_range(0.9, 1.1)


func _physics_process(delta):
	if(alert):
		human.rotation = human.global_position.direction_to(target.global_position).angle()
	move_and_slide()

func wake(enemy):
	if(not alert):
		alert = true
		fire_timer.start()
		target = enemy


func _on_body_entered(body):
	if(body.get_class() == "CharacterBody2D" and "balls" in body):
		play_sound()
		body.add_size(value)
		if(Config.blood and bleeds):
			var level = area2d.get_parent().get_parent().get_parent()
			var bloodScene = ResourceLoader.load("res://blood.tscn")
			for i in range(50):
				var blood = bloodScene.instantiate()
				blood.rotation_degrees = randf_range(0, 360)
				blood.global_position.x = area2d.global_position.x + randf_range(-50, 50)
				blood.global_position.y = area2d.global_position.y + randf_range(-50, 50)
				blood.z_index = -1
				level.add_child(blood)
		queue_free()


func _on_fire_timer_timeout():
	var laser_scene = load("res://laser.tscn")
	var laser_instance = laser_scene.instantiate()
	laser_instance.rotation = human.rotation
	laser_instance.global_position = laser_spot.global_position
	get_parent().add_child(laser_instance)


func play_sound():
	var sound_player = AudioStreamPlayer.new()
	sound_player.stream = load("res://assets/sfx/eat_human_alt2.wav")
	sound_player.finished.connect(sound_player.queue_free)
	sound_player.bus = &"SFX"
	get_parent().add_child(sound_player)
	sound_player.play()
