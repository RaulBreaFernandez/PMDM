extends Area2D

var sound_finished = false

var level = 1
var hp = 1
var speed = 150
var damage = 5
var knockback_ammount = 100
var attack_size = 1.0

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
@onready var impactSound = $AttackImpact
signal remove_from_array(object)

func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle() + deg_to_rad(135)
	match level:
		1:
			hp = 2
			speed = 150
			damage = 5
			knockback_ammount = 100
			attack_size = 1.0
		2:
			hp = 2
			speed = 150
			damage = 10
			knockback_ammount = 100
			attack_size = 1.0
		3:
			hp = 2
			speed = 150
			damage = 10
			knockback_ammount = 100
			attack_size = 1.0
		4:
			hp = 2
			speed = 150
			damage = 15
			knockback_ammount = 100
			attack_size = 1.0
		5:
			hp = 3
			speed = 150
			damage = 15
			knockback_ammount = 100
			attack_size = 1.0
func _physics_process(delta):
	position += angle * speed * delta

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		$CollisionShape2D.set_deferred("disabled", true)
		$Sprite2D.visible = false
		if sound_finished == true:
			queue_free()
		emit_signal("remove_from_array", self)

func _on_timer_timeout():
	queue_free()
	
func _on_sound_play_finished():
	sound_finished = true
