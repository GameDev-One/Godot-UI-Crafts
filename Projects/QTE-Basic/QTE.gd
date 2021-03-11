extends Control

const QTE_ACTION_NAME = "qte_select"

enum Type{SINGLE_HIT, MASH, HOLD}

export(String) var input_char = "K"
export (Type) var behavior = Type.MASH
export(float, 1, 30) var time_remaining: float = 3.0
export(int, 1, 25) var base_num_presses: int = 10
export(Texture) var texture_progress = null
export(Resource) var font = null

onready var InputPrompt: Label = $VBoxContainer/Prompt
onready var CountdownTime: Timer = $CountdownTimer
onready var CountdownBar: ProgressBar = $VBoxContainer/CountdownBar
onready var ProgressInd: TextureProgress = $ProgressIndicator
onready var Anim: AnimationPlayer = $AnimationPlayer
onready var Twn: Tween = $Tween

signal completed
signal failed


# Called when the node enters the scene tree for the first time.
func _ready():
	initalize_type()
	ProgressInd.texture_progress = texture_progress
	InputPrompt.text = input_char
	InputPrompt.set("custom_fonts/font", font)
	create_qte_input_event()
	
	CountdownTime.start(time_remaining)
	
func _input(event):
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
					Twn.interpolate_property(ProgressInd, "value", ProgressInd.value, ProgressInd.max_value, input_delay, Tween.TRANS_SINE, Tween.EASE_OUT_IN)
					Twn.resume_all()


func _process(delta):
	if ProgressInd.value >= ProgressInd.max_value:
		stop()
		emit_signal("completed")
	else:
		ProgressInd.value -= delta
		
	var time_slice: float = CountdownTime.time_left / CountdownTime.wait_time
	CountdownBar.value = time_slice * CountdownBar.max_value
	
	Twn.stop_all()
	
	
func create_qte_input_event():
	var ev = InputEventKey.new()
	ev.scancode = OS.find_scancode_from_string(input_char)
	InputMap.add_action(QTE_ACTION_NAME)
	InputMap.action_add_event(QTE_ACTION_NAME, ev)


func check_input(dt: float):
	match behavior:
		Type.SINGLE_HIT:
			if Input.is_action_just_pressed(QTE_ACTION_NAME):
				stop()
				emit_signal("completed")
		Type.MASH:
			if Input.is_action_just_pressed(QTE_ACTION_NAME):
				ProgressInd.value += ProgressInd.max_value / base_num_presses
		Type.HOLD:
			if Input.is_action_pressed(QTE_ACTION_NAME):
				var time_slice = sqrt(1 / CountdownTime.wait_time) / 2
				ProgressInd.value += dt * base_num_presses + time_slice


func initalize_type():
	match behavior:
		Type.SINGLE_HIT:
			CountdownBar.hide()
			ProgressInd.hide()
		Type.MASH:
			pass
		Type.HOLD:
			CountdownBar.hide()


func stop():
	set_process(false)
	set_process_input(false)
	Anim.stop()


func _on_CountdownTimer_timeout():
	emit_signal("failed")
