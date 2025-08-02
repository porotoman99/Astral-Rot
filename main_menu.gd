extends Control

@onready var title_screen = $TitleScreen
@onready var levels = $Levels
@onready var options = $Options
@onready var level = $Level
@onready var _2 = $"Levels/Buttons/2"
@onready var _3 = $"Levels/Buttons/3"
@onready var _4 = $"Levels/Buttons/4"
@onready var _5 = $"Levels/Buttons/5"
@onready var music_player = $MusicPlayer
@onready var track = 1
@onready var music = AudioServer.get_bus_index("Music")
@onready var sfx = AudioServer.get_bus_index("SFX")
@onready var music_slider = $Options/OptionsButtons/MusicSlider
@onready var sound_slider = $Options/OptionsButtons/SoundSlider

# Called when the node enters the scene tree for the first time.
func _ready():
	music_slider.value = AudioServer.get_bus_volume_linear(music)
	sound_slider.value = AudioServer.get_bus_volume_linear(sfx)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if(event.is_action_pressed("pause")):
		titleScreen()

func _on_exit_pressed():
	get_tree().quit()


func _on_level_select_pressed():
	title_screen.hide()
	levels.show()

func titleScreen():
	unload_level()
	options.hide()
	levels.hide()
	level.hide()
	title_screen.show()
	if(track != 1):
		track = 1
		music_player.stream = load("res://assets/The Biomorph.ogg")
		music_player.play()


func _on_options_pressed():
	title_screen.hide()
	options.show()


func unload_level():
	level.hide()
	for l in level.get_children():
		level.remove_child(l)
		l.queue_free()

func loadLevel1():
	print("Loading level 1")
	options.hide()
	levels.hide()
	title_screen.hide()
	unload_level()
	var levelScene = ResourceLoader.load("res://level_1.tscn")
	var levelInstance = levelScene.instantiate()
	level.add_child(levelInstance)
	levelInstance.ending.connect(loadLevel2)
	level.show()


func loadLevel2():
	print("Loading level 2")
	options.hide()
	levels.hide()
	title_screen.hide()
	unload_level()
	var levelScene = ResourceLoader.load("res://level_2.tscn")
	var levelInstance = levelScene.instantiate()
	level.add_child(levelInstance)
	levelInstance.ending.connect(loadLevel3)
	level.show()
	_2.disabled = false


func loadLevel3():
	print("Loading level 3")
	options.hide()
	levels.hide()
	title_screen.hide()
	unload_level()
	var levelScene = ResourceLoader.load("res://level_3.tscn")
	var levelInstance = levelScene.instantiate()
	level.add_child(levelInstance)
	levelInstance.ending.connect(loadLevel5)
	level.show()
	_3.disabled = false
	if(track != 2):
		track = 2
		music_player.stream = load("res://assets/You Are An Ecophage.ogg")
		music_player.play()


func loadLevel4():
	print("Loading level 4")
	options.hide()
	levels.hide()
	title_screen.hide()
	unload_level()
	var levelScene = ResourceLoader.load("res://level_4.tscn")
	var levelInstance = levelScene.instantiate()
	level.add_child(levelInstance)
	levelInstance.ending.connect(loadLevel5)
	level.show()
	_4.disabled = false
	if(track != 3):
		track = 3
		music_player.stream = load("res://assets/Pulsar.ogg")
		music_player.play()


func loadLevel5():
	print("Loading level 5")
	options.hide()
	levels.hide()
	title_screen.hide()
	unload_level()
	var levelScene = ResourceLoader.load("res://level_5.tscn")
	var levelInstance = levelScene.instantiate()
	level.add_child(levelInstance)
	levelInstance.ending.connect(titleScreen)
	level.show()
	_5.disabled = false
	if(track != 3):
		track = 3
		music_player.stream = load("res://assets/Pulsar.ogg")
		music_player.play()


func _on_blood_check_toggled(toggled_on):
	Config.blood = toggled_on


func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_linear(music, value)


func _on_sound_slider_value_changed(value):
	AudioServer.set_bus_volume_linear(sfx, value)
