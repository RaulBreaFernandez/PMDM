extends Node


const ITEM_PATH = "res://Utility/Items/"
const WEAPON_PATH = "res://Utility/Weapons/"
const UPGRADE = {
	
	"healing_potion": {
		"icon": ITEM_PATH + "Red Potion 3.png",
		"display_name": "Healing Potion",
		"details": "It heals you for 20 hp",
		"level": "N/A",
		"prerequisite": [],
		"type": "item"
	},
	"bow1": {
		"icon": WEAPON_PATH + "Bow.png",
		"display_name": "Elven Bow",
		"details": "Your character shoots an arrow at a random enemy. Legolas' favorite.",
		"level": "level 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"bow2": {
		"icon": WEAPON_PATH + "Bow.png",
		"display_name": "Elven Bow",
		"details": "Your arrows deal  more damage",
		"level": "level 2",
		"prerequisite": ["bow1"],
		"type": "weapon"
	},
		"bow3": {
		"icon": WEAPON_PATH + "Bow.png",
		"display_name": "Elven Bow",
		"details": "You shoot one more arrow.",
		"level": "level 3",
		"prerequisite": ["bow2"
		],
		"type": "weapon"
	},
	"bow4": {
		"icon": WEAPON_PATH + "Bow.png",
		"display_name": "Elven Bow",
		"details": "Your arrows deal  more damage",
		"level": "level 4",
		"prerequisite": ["bow3"],
		"type": "weapon"
	},
	"bow5": {
		"icon": WEAPON_PATH + "Bow.png",
		"display_name": "Elven Bow",
		"details": "You shoot one more arrow.",
		"level": "level 5",
		"prerequisite": ["bow4"],
		"type": "weapon"
	},
	"silver_sword1": {
		"icon": WEAPON_PATH + "Silver Sword.png",
		"display_name": "Silver Sword",
		"details": "A silver sword flies around you attacking your enemies. Yout get 1 sword per level It use to belong to a witcher",
		"level": "level 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"silver_sword2": {
		"icon": WEAPON_PATH + "Silver Sword.png",
		"display_name": "Silver Sword",
		"details": "Your flying swords deal more damage",
		"level": "level 2",
		"prerequisite": ["silver_sword1"],
		"type": "weapon"
	},
	"silver_sword3": {
		"icon": WEAPON_PATH + "Silver Sword.png",
		"display_name": "Silver Sword",
		"details": "Your swords dash one more time against enemies",
		"level": "level 3",
		"prerequisite": ["silver_sword2"],
		"type": "weapon"
	},
	"silver_sword4": {
		"icon": WEAPON_PATH + "Silver Sword.png",
		"display_name": "Silver Sword",
		"details": "Your flying swords deal more damage",
		"level": "level 4",
		"prerequisite": ["silver_sword3"],
		"type": "weapon"
	},
	"silver_sword5": {
		"icon": WEAPON_PATH + "Silver Sword.png",
		"display_name": "Silver Sword",
		"details": "Your swords dash one more time against enemiese",
		"level": "level 5",
		"prerequisite": ["silver_sword4"],
		"type": "weapon"
	},
	"sapphire_staff1": {
		"icon": WEAPON_PATH + "Sapphire Staff.png",
		"display_name": "Sapphire Staff",
		"details": "You shoot an icy projectile that pass through enemies. You shall not pass. Or so they say",
		"level": "level 1",
		"prerequisite": [],
		"type": "weapon"
	},
	"sapphire_staff2": {
		"icon": WEAPON_PATH + "Sapphire Staff.png",
		"display_name": "Sapphire Staff",
		"details": "Your icy projectile is stronger.",
		"level": "level 2",
		"prerequisite": ["sapphire_staff1"],
		"type": "weapon"
	},
	"sapphire_staff3": {
		"icon": WEAPON_PATH + "Sapphire Staff.png",
		"display_name": "Sapphire Staff",
		"details": "Your icy projectile passes through one more enemy.",
		"level": "level 3",
		"prerequisite": ["sapphire_staff2"],
		"type": "weapon"
	},
	"sapphire_staff4": {
		"icon": WEAPON_PATH + "Sapphire Staff.png",
		"display_name": "Sapphire Staff",
		"details": "Your icy projectile is stronger.",
		"level": "level 4",
		"prerequisite": ["sapphire_staff3"],
		"type": "weapon"
	},
	"sapphire_staff5": {
		"icon": WEAPON_PATH + "Sapphire Staff.png",
		"display_name": "Sapphire Staff",
		"details": "Your icy projectile passes through one more enemy.",
		"level": "level 5",
		"prerequisite": ["sapphire_staff4"],
		"type": "weapon"
	},
	"armor1": {
		"icon": ITEM_PATH + "Iron Armor.png",
		"display_name": "Iron Armor",
		"details": "Attack from your enemies deal 1 less damage to you",
		"level": "level 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"armor2": {
		"icon": ITEM_PATH + "Iron Armor.png",
		"display_name": "Iron Armor",
		"details": "Attack from your enemies deal 2 less damage to you",
		"level": "level 2",
		"prerequisite": ["armor1"],
		"type": "upgrade"
	},
	"armor3": {
		"icon": ITEM_PATH + "Iron Armor.png",
		"display_name": "Iron Armor",
		"details": "Attack from your enemies deal 3 less damage to you",
		"level": "level 3",
		"prerequisite": ["armor2"],
		"type": "upgrade"
	},
	"armor4": {
		"icon": ITEM_PATH + "Iron Armor.png",
		"display_name": "Iron Armor",
		"details": "Attack from your enemies deal 4 less damage to you",
		"level": "level 4",
		"prerequisite": ["armor3"],
		"type": "upgrade"
	},
	"armor5": {
		"icon": ITEM_PATH + "Iron Armor.png",
		"display_name": "Iron Armor",
		"details": "Attack from your enemies deal 5 less damage to you",
		"level": "level 5",
		"prerequisite": ["armor4"],
		"type": "upgrade"
	},
	"boots1": {
		"icon": ITEM_PATH + "Leather Boot.png",
		"display_name": "Leather Boots",
		"details": "You are 5% faster. You cant bo barefoot my friend",
		"level": "level 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"boots2": {
		"icon": ITEM_PATH + "Leather Boot.png",
		"display_name": "Leather Boots",
		"details": "You are 5% faster. You cant bo barefoot my friend",
		"level": "level 2",
		"prerequisite": ["boots1"],
		"type": "upgrade"
	},
	"boots3": {
		"icon": ITEM_PATH + "Leather Boot.png",
		"display_name": "Leather Boots",
		"details": "You are 5% faster. You cant bo barefoot my friend",
		"level": "level 2",
		"prerequisite": ["boots2"],
		"type": "upgrade"
	},
	"boots4": {
		"icon": ITEM_PATH + "Leather Boot.png",
		"display_name": "Leather Boots",
		"details": "You are 5% faster. You cant bo barefoot my friend",
		"level": "level 4",
		"prerequisite": ["boots3"],
		"type": "upgrade"
	},
	"boots5": {
		"icon": ITEM_PATH + "Leather Boot.png",
		"display_name": "Leather Boots",
		"details": "You are 5% faster. You cant bo barefoot my friend",
		"level": "level 5",
		"prerequisite": ["boots4"],
		"type": "upgrade"
	},
	"ring1": {
		"icon": ITEM_PATH + "Vitality Ring.png",
		"display_name": "Vitality Ring",
		"details": "Your max hp points are increased by 20",
		"level": "level 1",
		"prerequisite": [],
		"type": "upgrade"
	},
	"ring2": {
		"icon": ITEM_PATH + "Vitality Ring.png",
		"display_name": "Leather Boots",
		"details": "Your max hp points are increased by 20",
		"level": "level 2",
		"prerequisite": ["ring1"],
		"type": "upgrade"
	},
	"ring3": {
		"icon": ITEM_PATH + "Vitality Ring.png",
		"display_name": "Leather Boots",
		"details": "Your max hp points are increased by 20",
		"level": "level 3",
		"prerequisite": ["ring2"],
		"type": "upgrade"
	},
	"ring4": {
		"icon": ITEM_PATH + "Vitality Ring.png",
		"display_name": "Leather Boots",
		"details": "Your max hp points are increased by 20",
		"level": "level 4",
		"prerequisite": ["ring3"],
		"type": "upgrade"
	},
	"ring5": {
		"icon": ITEM_PATH + "Vitality Ring.png",
		"display_name": "Leather Boots",
		"details": "Your max hp points are increased by 20",
		"level": "level 5",
		"prerequisite": ["ring4"],
		"type": "upgrade"
	}
} 
