extends PanelContainer

@onready var attribute_name = $MarginContainer/VBoxContainer/AttributeName
@onready var feature1_name = $MarginContainer/VBoxContainer/Feature1
@onready var feature1_description = $MarginContainer/VBoxContainer/Feature1Description
@onready var feature2_name = $MarginContainer/VBoxContainer/Feature2
@onready var feature2_description = $MarginContainer/VBoxContainer/Feature2Description

func showClassInformation(character_class: CharacterClass, character_subclass: CharacterSubclass, position_anchor: Vector2, entered_size: Vector2):
	self.global_position = Vector2(
		position_anchor[0] + entered_size[0]/2, 
		position_anchor[1] + entered_size[1] + 10
	)
	
	attribute_name.text = character_class.name + " (" + character_subclass.subclass_name + ")"
	feature1_name.text = "Hope Feature: " + character_class.hope_feature.feature_name
	feature1_description.text = character_class.hope_feature.get_description()

	feature2_name.hide()
	feature2_description.hide()
	show()
	
func showAncestryInformation(ancestry: Ancestry, position_anchor: Vector2, entered_size: Vector2):
	self.global_position = Vector2(
		position_anchor[0] + entered_size[0]/2, 
		position_anchor[1] + entered_size[1] + 10
	)
	
	attribute_name.text = ancestry.ancestry_name
	feature1_name.text = ancestry.feature1.feature_name
	feature1_description.text = ancestry.feature1.get_description()
	
	feature2_name.text = ancestry.feature2.feature_name
	feature2_description.text = ancestry.feature2.get_description()
	
	feature2_name.show()
	feature2_description.show()
	
	show()
	
func showCommunityInformation(community: Community, position_anchor: Vector2, entered_size: Vector2):
	self.global_position = Vector2(
		position_anchor[0] + entered_size[0]/2, 
		position_anchor[1] + entered_size[1] + 10
	)
	
	attribute_name.text = community.community_name
	feature1_name.text = community.get_feature()
	feature1_description.text = community.get_feature_description()

	feature2_name.hide()
	feature2_description.hide()

	show()
