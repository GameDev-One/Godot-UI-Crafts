extends Control


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
	pass


"""
# brief			Called when an InputEventKey hasn't been consumed by _input() or
				any GUI.
# param event
				Input event that occured.
"""
func _unhandled_input(event: InputEvent) -> void:
	pass


"""
# brief			Called during the processing step of the main loop. Processing 
				happens at every frame and as fast as possible, so the delta 
				time since the previous frame is not constant.
# param delta
				Amount of time that has passed since last call to _process.
"""
func _process(delta: float) -> void:
	pass


"""
# brief		Halts all processing of the QTE and stops any playing animations.
"""
func stop() -> void:
	pass


"""
# brief		Creates a custom action in the InputMap for the QTE based off of the
			'input_char'.
"""
func _create_qte_input_event():
	pass


"""
# brief		Sets up the QTE Node based off of the selected behavior. 
"""
func _initalize_behavior():
	pass


"""
# brief		Emits the 'failed' signal when there is no more time remaining.
"""
func _on_CountdownTimer_timeout():
	pass

