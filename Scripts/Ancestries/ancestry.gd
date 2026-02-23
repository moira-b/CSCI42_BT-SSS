# This will be the base ancestry class script
# inherited by all ancestries.
class_name Ancestry
extends Resource

@export var ancestry_name: String
@export var feature1: AncestryFeature
@export var feature2: AncestryFeature

var description: String

func _ready() -> void:
	self.description = self.set_description()
	
func set_description() -> String:
	var all_descriptions: Dictionary = {
	}
	
	return all_descriptions[self.ancestry_name]
