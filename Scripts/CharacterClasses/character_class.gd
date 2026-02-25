# This will be the base character class script
# inherited by all character classes.
class_name CharacterClass
extends Resource


@export var name: String
@export var domains: Array[Domain]
@export var starting_evasion: int
@export var hope_feature: CharacterClassFeature
@export var class_items: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
