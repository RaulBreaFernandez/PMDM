extends CharacterBody2D

#Player
var hp = 100
var maxhp = 100
var movement_speed = 100
var experience = 0
var player_level = 1
var collected_experience = 0
var time = 0

#Attacks
var arrow = preload("res://Attacks/Arrow.tscn")
var crystal_spell = preload("res://Attacks/magic_attack(sapphire_staff).tscn")
var silver_sword = preload("res://Attacks/silver_sword.tscn")

#AttackNodes
@onready var arrowTimer = get_node("%ArrowTimer")
@onready var arrowAttackTimer = get_node("%ArrowAttackTimer")
@onready var crystalSpellTimer = get_node("%CrystalSpellTimer")
@onready var crystalSpellAttackTimer = get_node("%CrystalSpellAttackTimer")
@onready var silverSwordBase = get_node("%SilverSwordBase")
@onready var sprite = $Sprite2D
@onready var walkTimer = get_node("%WalkTimer")

#UPGRADES
var collected_upgrades = []
var upgrade_option = []
var armor = 0
var speed = 0
var spell_cooldown = 0
var spell_size = 0
var additional_attacks = 0

#GUI
@onready var expBar = get_node("%ExpBar")
@onready var LabelLevel = get_node("%LabelLevel")
@onready var levelPanel = get_node("%LevelUp")
@onready var upgradeOptions = get_node("%UpgradeOptions")
@onready var itemOptions = preload("res://Utility/item_option.tscn")
@onready var healthbar = get_node("%HealthBar")
@onready var labelTimer = get_node("%LabelTimer")
@onready var calcTimeTimer = get_node("%CalcTimeTimer")
@onready var collectedWeapons = get_node("%CollectedWeapons")
@onready var collectedUpgrades = get_node("%CollectedUpgrades")
@onready var itemContainer = preload("res://Utility/item_container.tscn")
@onready var animation = get_node("%AnimationPlayer")
@onready var deathPanel = get_node("%DeathPanel")
@onready var labelResult = get_node("%Label_Result")
@onready var victorySound = get_node("%VictorySound")
@onready var defeatSound = get_node("%DefeatSound")

var s = 0
var m = 0

#Arrow
var arrow_ammo = 0
var arrow_base_ammo = 1
var arrow_attack_speed = 1.5
var arrow_level = 0

#Crystal Attack
var crystal_spell_ammo = 0
var crystal_spell_base_ammo = 1
var crystal_spell_attack_speed = 2.5
var crystal_spell_level = 0

#FlyingSword
var flying_sword_ammo = 0
var flying_sword_level = 0

#Enemy related
var enemy_close = []

func _ready():
	animation.play("walk")
	arrow_attack()
	crystal_spell_attack()
	silver_sword_attack()
	set_expbar(experience, calculate_experiencecap())
	_on_hurt_box_hurt(0, 0, 0)
		
func crystal_spell_attack():
	if crystal_spell_level > 0:
		crystalSpellTimer.wait_time = crystal_spell_attack_speed
		if crystalSpellTimer.is_stopped():
			crystalSpellTimer.start()

func arrow_attack():
	if arrow_level > 0:
		arrowTimer.wait_time = arrow_attack_speed
		if arrowTimer.is_stopped():
			arrowTimer.start()
			
func silver_sword_attack():
	if flying_sword_level > 0:
		spawn_flying_sword()

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * movement_speed
	if velocity.x > 0.1:
		sprite.flip_h = true
	elif velocity.x < 0.1:
		sprite.flip_h = false

func _physics_process(_delta):
	var get_m = 0
	var get_s = 0
	if s > 59:
		m += 1
		s = 0
	if s < 10:
		get_s = str(0, s)
	else:
		get_s = s
	if m < 10:
		get_m = str(0, m)
	else:
		get_m = m
	labelTimer.text = str(get_m)+":"+str(get_s)
	get_input()
	move_and_slide()

func _on_hurt_box_hurt(damage, _angle, _knockback):
	hp -= clamp(damage-armor, 1.0, 999.0)
	healthbar.max_value = maxhp
	healthbar.value = hp
	if hp <= 0:
		death()

func _on_arrow_attack_timer_timeout():
	if arrow_ammo > 0:
		var arrow_attack = arrow.instantiate()
		arrow_attack.position = position
		arrow_attack.target = get_random_target()
		arrow_attack.level = arrow_level
		add_child(arrow_attack)
		arrow_ammo -= 1
		if arrow_ammo > 0:
			arrowAttackTimer.start()
		else:
			arrowAttackTimer.stop()
			
func _on_crystal_spell_attack_timer_timeout():
	if crystal_spell_ammo > 0:
		var crystal_spell_attack = crystal_spell.instantiate()
		crystal_spell_attack.position = position
		crystal_spell_attack.target = get_random_target()
		crystal_spell_attack.level = crystal_spell_level
		add_child(crystal_spell_attack)
		crystal_spell_ammo -= 1
		if crystal_spell_ammo > 0:
			crystalSpellAttackTimer.start()
		else:
			crystalSpellAttackTimer.stop()
			
func _on_arrow_timer_timeout():
	arrow_ammo += arrow_base_ammo 
	arrowAttackTimer.start()
	
func _on_crystal_spell_timer_timeout():
	crystal_spell_ammo += crystal_spell_base_ammo
	crystalSpellAttackTimer.start()
	
func spawn_flying_sword():
	var get_flying_total = silverSwordBase.get_child_count()
	var calc_spawns = flying_sword_ammo - get_flying_total
	while calc_spawns > 0:
		var silver_sword_spawn = silver_sword.instantiate()
		silver_sword_spawn.global_position = global_position
		silverSwordBase.add_child(silver_sword_spawn)
		calc_spawns -= 1

func _on_enemy_detection_area_body_entered(body):
			if not enemy_close.has(body):
				enemy_close.append(body)

func _on_enemy_detection_area_body_exited(body):
		if enemy_close.has(body):
			enemy_close.erase(body)

func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP

func _on_grab_area_area_entered(area):
	if area.is_in_group("loot"):
		area.target = self

func _on_collect_area_area_entered(area):
	if area.is_in_group("loot"):
		var gem_exp = area.collect()
		calculate_experience(gem_exp)
		
func calculate_experience(gem_exp):
	var exp_required = calculate_experiencecap()
	collected_experience += gem_exp
	if experience + collected_experience >= exp_required: #level up
		collected_experience -= exp_required - experience
		player_level += 1
		experience = 0
		exp_required = calculate_experiencecap()
		level_up()
		$LevelUpSound.play()
	else:
		experience += collected_experience
		collected_experience = 0
		
	set_expbar(experience, exp_required)

func calculate_experiencecap():
	var exp_cap = player_level
	if player_level < 20:
		exp_cap = player_level * 5
	elif player_level < 40:
		exp_cap = 95 + (player_level - 19) * 8
	else:
		exp_cap = 255 + (player_level - 39) * 12
		
	return exp_cap

func set_expbar(set_value = 1, set_max_value = 100):
	expBar.value = set_value
	expBar.max_value = set_max_value
	
func level_up():
	LabelLevel.text = str("level: ", player_level)
	levelPanel.visible = true
	var options = 0
	var options_max = 3
	while options < options_max:
		var option_choice = itemOptions.instantiate()
		option_choice.item = get_random_item()
		upgradeOptions.add_child(option_choice)
		options += 1
	get_tree().paused = true
	
func upgrade_character(upgrade):
	match upgrade:
		"healing_potion":
			hp += 20
			hp = clamp(hp,0,maxhp)
		"bow1":
			arrow_level = 1
		"bow2":
			arrow_level = 2
			arrow_base_ammo = 1
		"bow3":
			arrow_level = 3
			arrow_base_ammo = 2
		"bow4":
			arrow_level = 4
			arrow_base_ammo = 2
		"bow5":
			arrow_level = 5
			arrow_base_ammo = 3
		"silver_sword1":
			flying_sword_level = 1
			flying_sword_ammo = 1
		"silver_sword2":
			flying_sword_level = 2
			flying_sword_ammo = 2
		"silver_sword3":
			flying_sword_level = 3
			flying_sword_ammo = 3
		"silver_sword4":
			flying_sword_level = 4
			flying_sword_ammo += 1
		"silver_sword5":
			flying_sword_level = 5
			flying_sword_ammo = 5
		"sapphire_staff1":
			crystal_spell_level = 1
		"sapphire_staff2":
			crystal_spell_level = 2
			crystal_spell_base_ammo = 2
		"sapphire_staff3":
			crystal_spell_level = 3
			crystal_spell_base_ammo = 3
		"armor1":
			armor = 1
		"armor2":
			armor = 2
		"armor3":
			armor = 3
		"armor4":
			armor = 4
		"armor5":
			armor = 5
		"ring1":
			maxhp += 20
			hp += 20
			hp = clamp(hp, 20, maxhp)
		"ring2":
			maxhp += 20
			hp += 20
			hp = clamp(hp, 20, maxhp)
		"ring3":
			maxhp += 20
			hp += 20
			hp = clamp(hp, 20, maxhp)
		"ring4":
			maxhp += 20
			hp += 20
			hp = clamp(hp, 20, maxhp)
		"ring5":
			maxhp += 20
			hp += 20
			hp = clamp(hp, 20, maxhp)
		"boots1":
			movement_speed = 105
		"boots2":
			movement_speed = 110.25
		"boots3":
			movement_speed = 115.76
		"boots4":
			movement_speed = 121.54
		"boots5":
			movement_speed = 127.54
	adjust_gui_collection(upgrade)
	_ready()
	var option_children = upgradeOptions.get_children()
	for i in option_children:
		i.queue_free()
	upgrade_option.clear()
	collected_upgrades.append(upgrade)
	levelPanel.visible = false
	get_tree().paused = false
	calculate_experience(0)
	
func get_random_item():
	var dblist = []
	for i in UpgradeBd.UPGRADE:
		if i in collected_upgrades:
			pass
		elif i in upgrade_option:
			pass
		elif UpgradeBd.UPGRADE[i]["type"] == "item":
			pass
		elif UpgradeBd.UPGRADE[i]["prerequisite"].size() > 0:
			var to_add = true
			for n in UpgradeBd.UPGRADE[i]["prerequisite"]:
				if not n in collected_upgrades:
					to_add = false
			if to_add:
				dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() > 0:
		var randomItem = dblist.pick_random()
		upgrade_option.append(randomItem)
		return randomItem
	else:
		return null

func _on_timer_timeout():
	s += 1
	time += 1
	print(time)
	if hp > 0 and time > 360:
		deathPanel.visible = true
		get_tree().paused = true
		labelResult.text = "YOU WIN!"
		victorySound.play()

func adjust_gui_collection(upgrade):
	var get_upgraded_displaynames = UpgradeBd.UPGRADE[upgrade]["display_name"]
	var get_type = UpgradeBd.UPGRADE[upgrade]["type"]
	if get_type != "item":
		var get_collected_displaynames = []
		for i in collected_upgrades:
			get_collected_displaynames.append(UpgradeBd.UPGRADE[i]["display_name"])
		if not get_upgraded_displaynames in get_collected_displaynames:
			var new_item = itemContainer.instantiate()
			new_item.upgrade = upgrade 
			match get_type:
				"weapon":
					collectedWeapons.add_child(new_item)
				"upgrade":
					collectedUpgrades.add_child(new_item)
func death():
	deathPanel.visible = true
	get_tree().paused = true
	if time >= 360:
		labelResult.text = "YOU WIN!"
		victorySound.play()
	else:
		labelResult.text = "YOU LOSE!"
		defeatSound.play()

func _on_button_menu_click_end():
	get_tree().paused = false
	var _level = get_tree().change_scene_to_file("res://menu.tscn")
