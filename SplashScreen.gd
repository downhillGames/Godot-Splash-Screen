# ============================================================================
# Name        : SplashScreen.gd
# Author      : Tyler Schmidt
# Date        : 4/09/2019
# Project     : Generic Splash Screen
# Description : This script is meant to be attached to a Splash Screen Tree (Scene) and then instanced to the root node of the game
#			 	of a game created in Godot to start a basic splash screen upon launching the game. The Splash screen also 
#				features the ability to load resources and scenes needed for the next scene through the use of background threads.
#			    Open License, this code was uploaded to help others!
# ============================================================================


extends Node2D


onready var logoNode = get_node("logo")
var second_logo = preload("res://Assets/createdUsingGodot.PNG")

# CHANGE THESE VARIABLES TO SPEED / SLOW ANIMATION
var timer_count = 5
var image_full_time = 5
var transparency_amount = 0.03

var timer = timer_count
var transparency = 0
var image_full
var game_timer = 0
var is_visible
var image2_shown
var next_level

var loadingThread = Thread.new()

func _ready():

	image_full = false
	is_visible = false
	image2_shown = false
	
	logoNode.modulate = Color(1, 1, 1, 0.0)
	

func _process(delta):


	if (transparency > 0):
		is_visible = true
	else:
		is_visible = false
		
	#print(is_visible)
	

	if (timer == 0 && transparency < 1.0 && image_full == false):
		transparency += transparency_amount
		logoNode.modulate = Color(1, 1, 1, transparency)
		timer = timer_count
	elif (timer == 0 && transparency > 0.0 && image_full == true):
		transparency -= transparency_amount
		logoNode.modulate = Color(1, 1, 1, transparency)
		timer = timer_count
	elif (timer == 0 && image_full == true && transparency == 0.0):
		timer = timer_count
	elif (timer == 0 && transparency >= 1.0):
		image_full = true
		timer = image_full_time
	elif (timer > 0):
		timer -= 1
	
	if (timer == 0 && is_visible == false && image_full == true && image2_shown == false):
		timer = timer_count + 20
		image_full = false
		image2_shown = true
		loadingThread.start(self, "loadingThreadFunc")
		logoNode.set_texture(second_logo)
	elif (timer == 0 && is_visible == false && image_full == true && image2_shown == true):
		loadingThread.wait_to_finish()
		get_parent().add_child(next_level)
		
		get_parent().remove_child(self)
		self.call_deferred("free")
	
	
	game_timer+=1
	
	
func loadingThreadFunc(var data):
	print("loading main menu")
	var next_level_resource = load("res://scenes/TitleScreen.tscn")
	next_level = next_level_resource.instance()
	#get_parent().add_child(next_level)
	call_deferred("loadingThreadDone")
	
func loadingThreadDone():
    print("main menu loaded!")
	
	
