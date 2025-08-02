extends CharacterBody2D

@onready var player = $"."
@onready var dash_timer = $DashTimer
@onready var dash_cooldown = $DashCooldown
@onready var camera_2d = $Camera2D
@onready var animation_player = $AnimationPlayer
@onready var overlay = $Overlay
@onready var dead = false

const SPEED = 300.0
var screen_size
var canDash
@export var balls = 0
@export var dashable = false

func _ready():
	screen_size = get_viewport_rect().size
	canDash = true
	for i in range(balls):
		add_ball(i)

func _physics_process(delta):
	velocity = Vector2.ZERO
	var dash = 1
	if Input.is_action_pressed("moveRight"):
		velocity.x += 1
	if Input.is_action_pressed("moveLeft"):
		velocity.x -= 1
	if Input.is_action_pressed("moveDown"):
		velocity.y += 1
	if Input.is_action_pressed("moveUp"):
		velocity.y -= 1
	if Input.is_action_pressed("dash") and canDash and dashable:
		dash = 10 * player.scale.x
		if(dash_timer.is_stopped()):
			dash_timer.start()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED * dash
	
	move_and_slide()


func _on_dash_timer_timeout():
	canDash = false
	dash_cooldown.start()


func _on_dash_cooldown_timeout():
	canDash = true


func add_size(x: float):
	player.scale = Vector2(player.scale.x + x / 100.0, player.scale.y + x / 100.0)
	#camera_2d.zoom = Vector2(camera_2d.zoom.x - x / 100.0, camera_2d.zoom.y - x / 100.0)
	camera_2d.zoom.x = 1/player.scale.x
	camera_2d.zoom.y = 1/player.scale.y
	if balls != 0:
		while balls < player.scale.x*100.0:
			add_ball()


func lose_size(x: int):
	player.scale = Vector2(player.scale.x - x / 100.0, player.scale.y - x / 100.0)
	#camera_2d.zoom = Vector2(camera_2d.zoom.x + x / 100.0, camera_2d.zoom.y + x / 100.0)
	camera_2d.zoom.x = 1/player.scale.x
	camera_2d.zoom.y = 1/player.scale.y
	if(player.scale.x < 0.50 and not dead):
		dead = true
		$DeathSound.play()
		fade_out()
		$DeathTimer.start()


func add_ball(i: int = -1):
	if(i == -1):
		add_ball(balls)
		balls += 1
	else:
		var ball = ResourceLoader.load("res://metaball.tscn")
		var ballScene = ball.instantiate()
		ballScene.position = Vector2(cos(i)*(i+1)*0.1,sin(i)*(i+1)*0.1)
		player.add_child(ballScene)
		var jointScene = DampedSpringJoint2D.new()
		player.add_child(jointScene)
		jointScene.length = 0.001
		jointScene.stiffness = 100
		jointScene.rest_length = 0.1
		jointScene.node_a = player.get_path()
		jointScene.node_b = ballScene.get_path()


func fade_out():
	animation_player.play("fade_out")

func fade_out_slow():
	animation_player.speed_scale = 0.5
	animation_player.play("fade_out")


func _on_death_timer_timeout():
	get_parent().get_parent().get_parent().titleScreen()
