extends Node2D

@onready var edibles = $Edibles
@onready var level_end = false
@onready var ending_timer = $EndingTimer
@onready var player = $Player
@onready var locked = true
@onready var detector = $Doors/LockedDoor/Detector
@onready var button_sprite_2d = $Doors/LockedDoor/Button/Sprite2D
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

func unlock(body):
	if(locked and body.get_class() == "CharacterBody2D" and "balls" in body):
		locked = false
		$Doors/LockedDoor/Button/AudioStreamPlayer.play()
		detector.monitoring = true
		button_sprite_2d.texture = load("res://assets/button_on.png")


func wake_cafe():
	if(is_instance_valid($Edibles/Human7)):
		$Edibles/Human7.wake($Player)
	if(is_instance_valid($Edibles/Human8)):
		$Edibles/Human8.wake($Player)

func wake_engine():
	if(is_instance_valid($Edibles/Human9)):
		$Edibles/Human9.wake($Player)
	if(is_instance_valid($Edibles/Human10)):
		$Edibles/Human10.wake($Player)

func wake_closet():
	if(is_instance_valid($Edibles/Human11)):
		$Edibles/Human11.wake($Player)

func wake_bridge():
	if(is_instance_valid($Edibles/Human1)):
		$Edibles/Human1.wake($Player)
	if(is_instance_valid($Edibles/Human2)):
		$Edibles/Human2.wake($Player)
	if(is_instance_valid($Edibles/Human3)):
		$Edibles/Human3.wake($Player)
	if(is_instance_valid($Edibles/Human4)):
		$Edibles/Human4.wake($Player)
	if(is_instance_valid($Edibles/Human5)):
		$Edibles/Human5.wake($Player)
	if(is_instance_valid($Edibles/Human6)):
		$Edibles/Human6.wake($Player)
