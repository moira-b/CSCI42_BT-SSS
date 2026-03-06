# This will be the base character subclass script
# inherited by all character subclasses
class_name CharacterSubclass
extends Resource

@export var subclass_name: String
@export var foundation_feature: Array[CharacterClassFeature]
@export var specialization_feature: Array[CharacterClassFeature]
@export var mastery_feature: Array[CharacterClassFeature]
@export var spellcast_trait: CharacterTrait

var subclass_description: String
var subclass_description_file = "res://Resources/Classes/character_subclass_descriptions.json"
var feature_description: String

var json_as_text = FileAccess.get_file_as_string(subclass_description_file)
var json_as_dict = JSON.parse_string(json_as_text)

func set_description() -> String:
	subclass_description = json_as_dict.get(subclass_name)
	return subclass_description
