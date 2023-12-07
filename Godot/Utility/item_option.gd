extends ColorRect


var mouse_over = false
var item = null

@onready var player = get_tree().get_first_node_in_group("player")
@onready var lblName = $Label_Name
@onready var lblDescription = $Label_Description
@onready var lblLevel = $Label_Level
@onready var itemIcon = $ColorRect/ItemIcon

signal selected_upgrade(upgrade)

func _ready():
	connect("selected_upgrade", Callable(player, "upgrade_character"))
	if item == null:
		item = "healing_potion"
	lblName.text = UpgradeBd.UPGRADE[item]["display_name"]
	lblDescription.text = UpgradeBd.UPGRADE[item]["details"]
	lblLevel.text = UpgradeBd.UPGRADE[item]["level"]
	itemIcon.texture = load(UpgradeBd.UPGRADE[item]["icon"])

func _input(event):
	if event.is_action("click"):
		if mouse_over:
			emit_signal("selected_upgrade", item)

func _on_mouse_exited():
	mouse_over = false

func _on_mouse_entered():
	mouse_over = true
