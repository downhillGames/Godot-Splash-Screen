extends Node2D


onready var logoNode = get_node("logo")
var second_logo = preload("res://icon.png")

# CHANGE THESE VARIABLES TO SPEED / SLOW ANIMATION
var timer_count = 5
var image_full_time = 5
var transpanancy_amount = 0.02

var timer = timer_count
var transparancy1 = 0
var transparancy2 = 0
var image_full1
var image_full2
var game_timer = 0
var is_visible
var image2_shown

func _ready():

	image_full1 = false
	is_visible = false
	image2_shown = false
	
	logoNode.modulate = Color(1, 1, 1, 0.0)
	

func _process(delta):

	if (game_timer == 5):
		var next_level_resource = load("res://NextScene.tscn")
		var next_level = next_level_resource.instance()
		get_parent().add_child(next_level)
	if (game_timer == 10000):
		get_parent().remove_child(self)
		self.call_deferred("free")

	logoNode.modulate = Color(1, 1, 1, transparancy1)
	

	if (transparancy1 > 0):
		is_visible = true
	else:
		is_visible = false
		
	#print(is_visible)
	
	if (timer == 0 && transparancy1 < 1.0 && image_full1 == false):
		transparancy1 += transpanancy_amount
		timer = timer_count
	elif (timer == 0 && transparancy1 > 0.0 && image_full1 == true):
		transparancy1 -= transpanancy_amount
		timer = timer_count
	elif (timer == 0 && image_full1 == true && transparancy1 == 0.0):
		timer = timer_count
	elif (timer == 0 && logoNode.modulate == Color(1, 1, 1, 1.0)):
		image_full1 = true
		timer = image_full_time
	elif (timer > 0):
		timer -= 1
	
	if (timer == 0 && is_visible == false && image_full1 == true && image2_shown == false):
		timer = timer_count + 20
		image_full1 = false
		image2_shown = true
		logoNode.set_texture(second_logo)
	
	game_timer+=1
	
