extends Node2D

@onready var edibles = $Edibles
@onready var level_end = false
@onready var sun_edible = false
@onready var ending_timer = $EndingTimer
@onready var player = $Player
@onready var sun = $Edibles/Sun
@onready var orbit_1 = $Edibles/Orbit1
@onready var orbit_2 = $Edibles/Orbit2
@onready var orbit_3 = $Edibles/Orbit3
@onready var orbit_4 = $Edibles/Orbit4
@onready var orbit_5 = $Edibles/Orbit5
@onready var orbit_6 = $Edibles/Orbit6
@onready var orbit_7 = $Edibles/Orbit7
@onready var orbit_8 = $Edibles/Orbit8
@onready var asteroid_belt = $Edibles/AsteroidBelt
@onready var kuiper_belt = $Edibles/KuiperBelt
@onready var glow = $Player/Glow
@onready var black_hole = $Player/BlackHole
@onready var black_hole_timer = $Player/BlackHoleTimer
@onready var fade_timer = $Player/FadeTimer
@onready var animation_player_2 = $Player/AnimationPlayer2
signal ending

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(200):
		var asteroid_scene = load("res://asteroid.tscn")
		var asteroid_instance = asteroid_scene.instantiate()
		var asteroid_orbit = Node2D.new()
		asteroid_instance.position.x = 7000 + randi_range(-100, 100)
		asteroid_orbit.add_child(asteroid_instance)
		asteroid_orbit.rotation = randi_range(0, 360)
		asteroid_belt.add_child(asteroid_orbit)
	for i in range(500):
		var asteroid_scene = load("res://asteroid.tscn")
		var asteroid_instance = asteroid_scene.instantiate()
		var asteroid_orbit = Node2D.new()
		asteroid_instance.position.x = 13000 + randi_range(-100, 100)
		asteroid_orbit.add_child(asteroid_instance)
		asteroid_orbit.rotation = randi_range(0, 360)
		kuiper_belt.add_child(asteroid_orbit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(is_instance_valid(orbit_1)):
		orbit_1.rotation += 0.1 * delta
	if(is_instance_valid(orbit_2)):
		orbit_2.rotation += 0.03914940298441 * delta
	if(is_instance_valid(orbit_3)):
		orbit_3.rotation += 0.024084207397925 * delta
	if(is_instance_valid(orbit_4)):
		orbit_4.rotation += 0.01280519083525 * delta
	if(is_instance_valid(asteroid_belt)):
		if(asteroid_belt.get_child_count() == 0):
			asteroid_belt.queue_free()
		asteroid_belt.rotation += 0.02 * delta
	if(is_instance_valid(orbit_5)):
		orbit_5.rotation += 0.002030404446301 * delta
	if(is_instance_valid(orbit_6)):
		orbit_6.rotation += 0.00081788354082 * delta
	if(is_instance_valid(orbit_7)):
		orbit_7.rotation += 0.000286651677338 * delta
	if(is_instance_valid(orbit_8)):
		orbit_8.rotation += 0.000146140210981 * delta
	if(is_instance_valid(kuiper_belt)):
		if(kuiper_belt.get_child_count() == 0):
			kuiper_belt.queue_free()
		kuiper_belt.rotation += 0.02 * delta
	if(is_instance_valid(glow) and is_instance_valid(sun)):
		glow.rotation = player.global_position.direction_to(sun.global_position).angle()
		glow.modulate = Color(1,1,1,1/(player.global_position.distance_to(sun.global_position)/3000))
	if(edibles.get_child_count() == 1 and sun_edible == false):
		sun_edible = true
		sun.edible()
	if(edibles.get_child_count() == 0 and level_end == false):
		level_end = true
		glow.queue_free()
		black_hole_timer.start()


func next_level():
	ending.emit()


func _on_black_hole_timer_timeout():
	$Player/BlackHoleSound.play()
	black_hole.show()
	animation_player_2.play("black_hole")
	fade_timer.start()


func _on_fade_timer_timeout():
	player.fade_out_slow()
	ending_timer.start()


func _on_sun_eaten():
	glow.hide()
