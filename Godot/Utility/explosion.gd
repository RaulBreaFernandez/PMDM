extends Sprite2D

@onready var hitmarker = $Hitmarker

func _ready():
	hitmarker.play()
	$AnimationPlayer.play("Explosion")

func _on_animation_player_animation_finished(anim_name):
	queue_free()
