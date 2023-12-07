extends Area2D


@export var experience = 1

var exp_green = preload("res://Utility/Cut Emerald.png")
var exp_blue = preload("res://Utility/Cut Sapphire.png")
var exp_red = preload("res://Utility/Cut Ruby.png")

var target = null
var speed = -1

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $Exp_sound

func _ready():
	if experience < 5:
		return
	elif experience < 25:
		sprite.texture = exp_blue
	else:
		sprite.texture = exp_red

func _physics_process(delta):
	if target != null:
		global_position = global_position.move_toward(target.global_position, speed)
		speed += 2 * delta
		
func collect():
	sound.play()
	collision.call_deferred("set", "disabled")
	sprite.visible = false
	return experience

func _on_exp_sound_finished():
	queue_free()
