extends Control


"""
# file        qte.gd
# author(s)   Devone Reynolds
# par         email: gamedevone1@gmail.com
# date        11 MAR 2021
# copyright   Copyright (c) 2021 GameDevone
# brief       Prompts the user to provide a single or series of inputs based on 
			  an objective.
"""


signal completed
signal failed

# Possible behaviors the QTE can display
enum Type{SINGLE_HIT, MASH, HOLD}

# Default name of the custom action created in the InputMap
const QTE_ACTION_NAME = "qte_select"

# Single key input the user is requested to press.
export(String) var input_char = "K"

# Changes how you would like the user to complete and fail the objective.
export (Type) var behavior = Type.MASH

# Amount of time left before user fails the objective.
export(float, 1, 30) var time_remaining: float = 3.0

# The initial amount of pressed need to complete the QTE.
export(int, 1, 25) var base_num_presses: int = 10

# Image used to display progress of completion of the QTE. 
export(Texture) var texture_progress = null

# Font used for displaying the prompt.
export(Resource) var font = null

# Shorthand reference to children
onready var InputPrompt: Label = $VBoxContainer/Prompt
onready var CountdownTime: Timer = $CountdownTimer
onready var CountdownBar: ProgressBar = $VBoxContainer/CountdownBar
onready var ProgressInd: TextureProgress = $ProgressIndicator
onready var Anim: AnimationPlayer = $AnimationPlayer
onready var Twn: Tween = $Tween


"""
# brief		Called when the node is 'ready', i.e. when both the node and its 
			children have entered the scene tree.
"""
func _ready() -> void:
	_initalize_behavior()
	_create_qte_input_event()
	
	ProgressInd.texture_progress = texture_progress
	InputPrompt.text = input_char
	InputPrompt.set("custom_fonts/font", font)
	
	CountdownTime.start(time_remaining)


"""
# brief			Called when an InputEventKey hasn't been consumed by _input() or
				any GUI.
# param event
				Input event that occured.
"""
func _unhandled_input(event: InputEvent) -> void:
	match behavior:
		Type.SINGLE_HIT:
			if event.is_action_pressed(QTE_ACTION_NAME):
				emit_signal("completed")
			elif not event is InputEventMouse:
				emit_signal("failed")
		Type.MASH:
			if event.is_action_pressed(QTE_ACTION_NAME):
				ProgressInd.value += ProgressInd.max_value / base_num_presses
		Type.HOLD:
			if event is InputEventKey:
				if char(event.scancode) == input_char and event.is_echo():
					var input_delay = max(CountdownTime.time_left - (1 - (1 / time_remaining)), 0)
					Twn.interpolate_property(ProgressInd, 
							"value", 
							ProgressInd.value, 
							ProgressInd.max_value, 
							input_delay, 
							Tween.TRANS_SINE, 
							Tween.EASE_OUT_IN)
					Twn.resume_all()


"""
# brief			Called during the processing step of the main loop. Processing 
				happens at every frame and as fast as possible, so the delta 
				time since the previous frame is not constant.
# param delta
				Amount of time that has passed since last call to _process.
"""
func _process(delta: float) -> void:
	if ProgressInd.value >= ProgressInd.max_value:
		stop()
		emit_signal("completed")
	else:
		ProgressInd.value -= delta
		
	var time_slice: float = CountdownTime.time_left / time_remaining
	CountdownBar.value = time_slice * CountdownBar.max_value
	
	Twn.stop_all()


"""
# brief		Halts all processing of the QTE and stops any playing animations.
"""
func stop() -> void:
	set_process(false)
	set_process_input(false)
	Anim.stop()


"""
# brief		Creates a custom action in the InputMap for the QTE based off of the
			'input_char'.
"""
func _create_qte_input_event():
	var ev = InputEventKey.new()
	ev.scancode = OS.find_scancode_from_string(input_char)
	InputMap.add_action(QTE_ACTION_NAME)
	InputMap.action_add_event(QTE_ACTION_NAME, ev)


"""
# brief		Sets up the QTE Node based off of the selected behavior. 
"""
func _initalize_behavior():
	match behavior:
		Type.SINGLE_HIT:
			CountdownBar.hide()
			ProgressInd.hide()
		Type.MASH:
			pass
		Type.HOLD:
			CountdownBar.hide()


"""
# brief		Emits the 'failed' signal when there is no more time remaining.
"""
func _on_CountdownTimer_timeout():
	emit_signal("failed")

