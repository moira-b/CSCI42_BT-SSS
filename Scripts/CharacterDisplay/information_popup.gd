extends PanelContainer

@onready var attribute_name = $MarginContainer/VBoxContainer/AttributeName
@onready var spacer = $MarginContainer/VBoxContainer/Spacer
@onready var feature1_name = $MarginContainer/VBoxContainer/Feature1
@onready var feature1_description = $MarginContainer/VBoxContainer/Feature1Description
@onready var feature2_name = $MarginContainer/VBoxContainer/Feature2
@onready var feature2_description = $MarginContainer/VBoxContainer/Feature2Description
@onready var class_description = $MarginContainer/VBoxContainer/ClassDescription

var currently_showing: String = ""

func showClassInformation(character_class: CharacterClass, character_subclass: CharacterSubclass, position_anchor: Vector2, entered_size: Vector2):
	self.global_position = Vector2(
		position_anchor[0] + entered_size[0]/2, 
		position_anchor[1] + entered_size[1] + 10
	)
	
	attribute_name.hide()
	spacer.hide()
	feature1_name.hide()
	feature1_description.hide()
	feature2_name.hide()
	feature2_description.hide()
	class_description.show()
	
	if class_description.text == "":
		class_description.append_text("[font_size=16]%s[/font_size]" % [character_class.name] + "\n\n")
		class_description.append_text("[font_size=16]%s[/font_size]" % 
			[character_class.hope_feature.feature_name] + "\n")
		class_description.append_text(character_class.hope_feature.get_description() + "\n\n")
		class_description.append_text("[font_size=16]%s[/font_size]" % 
			[character_class.class_feature[0].feature_name] + "\n")
		class_description.append_text(character_class.class_feature[0].get_description() + "\n\n")
		class_description.append_text("[font_size=16]%s[/font_size]" % 
			[character_subclass.subclass_name] + "\n\n")
		if character_subclass.spellcast_trait != null:
			class_description.append_text("[font_size=16]Spellcast Trait - %s[/font_size]" % 
				[character_subclass.spellcast_trait.trait_name] + "\n\n")
		class_description.append_text("[font_size=16]Foundation Feature[/font_size]" + "\n")
		
		for feature in character_subclass.foundation_feature:
			class_description.append_text("[u] %s [/u]" % [feature.feature_name] + ": " + feature.get_description() + "\n")
		class_description.append_text("\n")
		class_description.append_text("[font_size=16]Specialization Feature[/font_size]" + "\n")
		
		for spec in character_subclass.specialization_feature:
			class_description.append_text("[u] %s [/u]" % [spec.feature_name] + ": " + spec.get_description() + "\n")
		class_description.append_text("\n")
		class_description.append_text("[font_size=16]Specialization Feature[/font_size]" + "\n")
		
		for mast in character_subclass.mastery_feature:
			class_description.append_text("[u] %s [/u]" % [mast.feature_name] + ": " + mast.get_description() + "\n")
		class_description.append_text("\n")
	
	set_size(self.get_minimum_size())
	show()
	
func showAncestryInformation(ancestry: Ancestry, position_anchor: Vector2, entered_size: Vector2):
	
	attribute_name.show()
	spacer.show()
	feature1_name.show()
	feature1_description.show()
	feature2_name.show()
	feature2_description.show()
	class_description.hide()
	
	self.global_position = Vector2(
		position_anchor[0] + entered_size[0]/2, 
		position_anchor[1] + entered_size[1] + 10
	)
	
	attribute_name.text = ancestry.ancestry_name
	feature1_name.text = "Ancestry Feature: " + ancestry.feature1.feature_name
	feature1_description.text = ancestry.feature1.get_description()
	
	feature2_name.text = "Ancestry Feature: " + ancestry.feature2.feature_name
	feature2_description.text = ancestry.feature2.get_description()
	
	feature2_name.show()
	feature2_description.show()
	
	set_size(self.get_minimum_size())
	show()
	
func showCommunityInformation(community: Community, position_anchor: Vector2, entered_size: Vector2):
	
	attribute_name.show()
	spacer.show()
	feature1_name.show()
	feature1_description.show()
	feature2_name.show()
	feature2_description.show()
	class_description.hide()
	
	self.global_position = Vector2(
		position_anchor[0] + entered_size[0]/2, 
		position_anchor[1] + entered_size[1] + 10
	)
	
	attribute_name.text = community.community_name
	feature1_name.text = "Community Feature: " + community.get_feature()
	feature1_description.text = community.get_feature_description()

	feature2_name.hide()
	feature2_description.hide()

	set_size(self.get_minimum_size())
	show()
	
func showEquipmentInformation(feature: String, desc:String, position_anchor: Vector2, entered_size: Vector2):
	attribute_name.text = feature
	feature1_name.text = desc
	feature1_description.text = ""
	
	attribute_name.show()
	spacer.hide()
	feature1_name.show()
	feature1_description.hide()
	feature2_name.hide()
	feature2_description.hide()
	class_description.hide()
	

	set_size(self.get_minimum_size())
	self.global_position = Vector2(
		position_anchor[0], 
		position_anchor[1] - entered_size[1]/2 - self.size[1]/2
	)
	show()

func set_currently_showing(s: String) -> void:
	if s not in ["Class", "Multiclass", "Ancestry", "Community"]:
		print("Error in information_popup.gd. Trying to set to info/attribute it is not prepared for.")
		return
	else:
		currently_showing = s

func hideInformation() -> void:
	self.currently_showing = ""
	hide()
