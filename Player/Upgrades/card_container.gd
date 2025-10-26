extends HBoxContainer

class_name CardContainer

signal card_selected

var selected: UpgradeCard = null

var rng:RandomNumberGenerator = RandomNumberGenerator.new()

# array of packed scenes
@export var cards: Array = []

func randomly_sample_cards():
	# First, kill all the children
	for c in get_children():
		c.queue_free() 
	
	#take the two first
	if(cards.size()<2):
		printerr("MUST EXIST AT LEAST TWO TYPES OF CARDS")
	else:
		add_child(cards[0].instantiate())
		add_child(cards[1].instantiate())
		add_child(cards[2].instantiate())
		

func select_me(card: UpgradeCard):
	if(selected != null):
		printerr("SELECTED A SECOND CARD IS NOT ALLOWED!")
	else:
		card_selected.emit()
		card.perform_upgrade()
		selected = card
		for child:Control in get_children():
			if(child == card):
				continue
			child.self_modulate.r = 0.6
			child.self_modulate.g = 0.6
			child.self_modulate.b = 0.6
		# make all the other cards dark
		
