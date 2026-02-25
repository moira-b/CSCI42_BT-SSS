# This will be the base character subclass script
# inherited by all character subclass features
class_name CharacterSubclass
extends CharacterClass

@export var subclass_name: String
@export var foundation_feature: Array[CharacterClassFeature]
@export var specialization_feature: Array[CharacterClassFeature]
@export var mastery_feature: Array[CharacterClassFeature]
