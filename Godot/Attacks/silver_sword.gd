extends Area2D


var level = 1
var hp = 99999999
var speed = 200.0
var damage = 10
var knockback_ammount = 100
var paths = 1
var attack_speed = 4.0
var attack_size = 1.0

var target = Vector2.ZERO
var target_array = []

var angle = Vector2.ZERO
var reset_pos = Vector2.ZERO

var sword = preload("res://Utility/Weapons/Silver Sword.png")

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var attackTimer = get_node("%AttackTimer")
@onready var changeDirectionTimer = get_node("%ChangeDirection")
@onready var resetPostTimer = get_node("%ResetPostTimter")
@onready var sound_attack = $SlashSound

signal remove_from_array(object)

func _ready():
	update_silver_sword()
	_on_reset_pos_timer_timeout()
	
func update_silver_sword():
	level = player.flying_sword_level
	match level:
		1:
			hp = 99999
			speed = 200
			damage = 5
			knockback_ammount = 100
			attack_size = 1.0
			paths = 1
			attack_speed = 4.0
		2:
			hp = 99999
			speed = 200
			damage = 15
			knockback_ammount = 100
			attack_size = 1.0
			paths = 1
			attack_speed = 4.0
		3:
			hp = 99999
			speed = 200
			damage = 15
			knockback_ammount = 100
			attack_size = 1.0
			paths = 2
			attack_speed = 4.0
		4:
			hp = 99999
			speed = 200
			damage = 20
			knockback_ammount = 100
			attack_size = 1.0
			paths = 2
			attack_speed = 4.0
		5:
			hp = 99999
			speed = 200
			damage = 20
			knockback_ammount = 100
			attack_size = 1.0
			paths = 3
			attack_speed = 4.0
	scale = Vector2(1.0, 1.0) * attack_size
	attackTimer.wait_time = attack_speed
	
func _physics_process(delta):
	if target_array.size() > 0:
		position += angle * speed * delta
	else:
		var player_angle = global_position.direction_to(reset_pos)
		var distance_diff = global_position - player.global_position
		var return_speed = 20
		if abs(distance_diff.x) > 500 or abs(distance_diff.y) > 500:
			return_speed = 100
		position += player_angle * return_speed * delta
		rotation  = global_position.direction_to(player.global_position).angle() + deg_to_rad(310)

func _on_attack_timer_timeout():
	add_paths()
	
func add_paths():
	sound_attack.play()
	emit_signal("remove_from_array", self)
	target_array.clear()
	var counter = 0
	while counter < paths:
		var new_path = player.get_random_target()
		target_array.append(new_path)
		counter += 1
		enable_attack(true)
	target = target_array[0]
	process_path()

func process_path():
	angle = global_position.direction_to(target)
	changeDirectionTimer.start()
	var tween = create_tween()
	var new_rotation_degree = angle.angle() + deg_to_rad(50)
	tween.tween_property(self, "rotation", new_rotation_degree, 0.25).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_OUT)
	tween.play()
	
func enable_attack(atk = true):
	if atk:
		collision.call_deferred("set", "disabled", false)
	else:
		collision.call_deferred("set", "disabled", true)

func _on_change_direction_timeout():
	if target_array.size() > 0:
		target_array.remove_at(0)
		if target_array.size() > 0:
			target = target_array[0]
			process_path()
			sound_attack.play()
			emit_signal("remove_from_array", self)
		else:
			enable_attack(false)
	else:
		changeDirectionTimer.stop()
		attackTimer.start()
		enable_attack(false)

func _on_reset_pos_timer_timeout():
	var choose_direction = randi() % 4
	reset_pos = player.global_position
	match choose_direction:
		0:
			reset_pos.x += 50
		1:
			reset_pos.x -= 50
		2:
			reset_pos.y += 50
		3:
			reset_pos.y -= 50
