# This will be the base community script
# inherited by all community classes.
class_name Community
extends Resource

var all_features: Dictionary = {
	"Highborne":"Privilege", 
	"Loreborne":"Well-Read",
	"Orderborne":"Dedicated",
	"Ridgeborne":"Steady",
	"Seaborne": "Know the Tide",
	"Slyborne": "Scoundrel",
	"Underborne": "Low-Light Living",
	"Wanderborne": "Nomadic Pack",
	"Wildborne": "Lightfoot",
}

var all_features_descriptions = {
	"Privilege": "You have advantage on rolls to consort with nobles, negotiate prices, or leverage your reputation to get what you want.",
	"Well-Read": "You have advantage on rolls that involve the history, culture, or politics of a prominent person or place.",
	"Dedicated": "Record three sayings or values your upbringing instilled in you. Once per rest, when you describe how you’re embodying one of these principles through your current action, you can roll a d20 as your Hope Die.",
	"Steady": "You have advantage on rolls to traverse dangerous cliffs and ledges, navigate harsh environments, and use your survival knowledge.",
	"Know the Tide":"You can sense the ebb and flow of life. When you roll with Fear, place a token on your community card. You can hold a number of tokens equal to your level. Before you make an action roll, you can spend any number of these tokens to gain a +1 bonus to the roll for each token spent. At the end of each session, clear all unspent tokens.",
	"Scoundrel":"You have advantage on rolls to negotiate with criminals, detect lies, or find a safe place to hide.",
	"Low-Light Living":"When you’re in an area with low light or heavy shadow, you have advantage on rolls to hide, investigate, or perceive details within that area.",
	"Nomadic Pack":"Add a Nomadic Pack to your inventory. Once per session, you can spend a Hope to reach into this pack and pull out a mundane item that’s useful to your situation. Work with the GM to figure out what item you take out.",
	"Lightfoot":"Your movement is naturally silent. You have advantage on rolls to move without being heard.",
}

var options: Array = ["Highborne", "Loreborne", "Orderborne", "Ridgeborne", "Seaborne", "Slyborne","Underborne","Wanderborne","Wildborne"] 
@export_enum("Highborne", "Loreborne", "Orderborne", "Ridgeborne", "Seaborne", "Slyborne",
		"Underborne","Wanderborne","Wildborne") var community_name: String
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	var a = ""
	
