# This will be the base character class feature script
# inherited by all character class features
class_name CharacterClassFeature
extends Resource

@export var feature_name: String
var class_features_file = "res://Resources/Classes/character_class_features.json"
var feature_description: String

var json_as_text = FileAccess.get_file_as_string(class_features_file)
var json_as_dict = JSON.parse_string(json_as_text)

func set_description() -> void:
	feature_description = json_as_dict.get(feature_name)

func get_description() -> String:
	return json_as_dict.get(feature_name)
