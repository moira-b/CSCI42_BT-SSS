extends PanelContainer

@onready var attribute_name = $MarginContainer/VBoxContainer/AttributeName
@onready var feature1_name = $MarginContainer/VBoxContainer/Feature1
@onready var feature1_description = $MarginContainer/VBoxContainer/Feature1Description
@onready var feature2_name = $MarginContainer/VBoxContainer/Feature2
@onready var feature2_description = $MarginContainer/VBoxContainer/Feature2Description

func showClassInformation(character_class: CharacterClass, character_subclass: CharacterSubclass):
	self.label.text = "Hovering over class"
	show()
	
func showAncestryInformation(ancestry: Ancestry):
	self.label.text = "Hovering over ancestry"
	show()
	
func showCommunityInformation(community: Community):
	attribute_name.text = community.community_name
	feature1_name.text = community.get_feature()
	feature1_description.text = community.get_feature_description()

	feature2_name.hide()
	feature2_description.hide()

	show()
