extends CharacterBody2D


@onready var hitSound = $HitSound
@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Walk
@onready var spriteDeath = $Death
@onready var animation = $AnimationPlayer
@onready var loot_base = get_tree().get_first_node_in_group("loot")

@export var movement_speed = 1
@export var hp = 1
@export var knockback_recovery = 1
@export var experience = 1
@export var enemy_counter = 0
@export var damage = 1

var knockback = Vector2.ZERO
var death_anim = preload("res://Utility/explosion.tscn")
var exp_gem = preload("res://Utility/experience_gem.tscn")

signal remove_from_array(object)

func _ready():
	animation.play("walk")
	
func death():
	emit_signal("remove_from_array", self)
	var enemy_death = death_anim.instantiate()
	enemy_death.scale = sprite.scale/2
	enemy_death.position = position
	get_parent().call_deferred("add_child", enemy_death)
	var new_gem = exp_gem.instantiate()
	new_gem.position = position
	new_gem.experience = experience
	get_parent().call_deferred("add_child", new_gem)
	queue_free()

func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	if direction.x < 0.1:
		sprite.flip_h = true
	elif direction.x > 0.1:
		sprite.flip_h = false
	velocity = direction * movement_speed
	velocity += knockback
	move_and_slide()

func _on_hurt_box_hurt(damage, angle, knockback_ammount):
	hp -= damage
	knockback = angle * knockback_ammount
	if hp <= 0:
		death()
	else:
		hitSound.play()
		
