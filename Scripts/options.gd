extends Sprite2D

var step = 0

var escapedisabled = false

func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_escape") and escapedisabled == false:
		if step == 0:
			Global.paused = !Global.paused
		else:
			step -= 1
		
	
	
	if step == 0:
		$Heading.play("Options")
		$Shadow.show()
		$OptionButtons.show()
		$VideoButtons.hide()
		$SoundButtons.hide()
		$ControlsButtons.hide()
		$Back.hide()
	else:
		$OptionButtons.hide()
		$Back.show()
	
	
	if Global.paused == true:
		self.show()
	else:
		self.hide()
	
	Global.size_x = int($VideoButtons/XResolutionEdit.text)
	Global.size_y = int($VideoButtons/YResolutionEdit.text)
	
	Global.brightness = $VideoButtons/Brightness.value
	Global.damageindicator = $VideoButtons/DamageIndicator.value
	
	Global.zoom = $VideoButtons/Zoom.value
	$VideoButtons/Zoom.value = Global.zoom
	
	Global.mastervolume = $SoundButtons/Master.value
	Global.musicvolume = $SoundButtons/Music.value
	Global.uivolume = $SoundButtons/UI.value
	Global.attackvolume = $SoundButtons/Attack.value
	Global.ambiencevolume = $SoundButtons/Ambience.value
	Global.titlescreenvolume = $SoundButtons/TitleScreen.value
	
	get_parent().get_parent().get_parent().find_child("Camera2D").zoom.x = Global.zoom
	get_parent().get_parent().get_parent().find_child("Camera2D").zoom.y = Global.zoom


func _on_journal_pressed():
	pass # Replace with function body.


func _on_close_pressed():
	Global.paused = false
	pass # Replace with function body.


func _on_controls_pressed():
	step += 1
	$Heading.play("Controls")
	$ControlsButtons.show()
	
	pass # Replace with function body.


func _on_exit_pressed():
	
	##################################### ADD SAVING
	
	get_tree().quit()
	pass # Replace with function body.


func _on_sound_pressed():
	step += 1
	$Heading.play("Sound")
	$SoundButtons.show()
	
	pass # Replace with function body.


func _on_title_pressed():
	
	##################################### ADD SAVING
	
	pass # Replace with function body.


func _on_video_pressed():
	step += 1
	$Heading.play("Video")
	$VideoButtons.show()
	
	pass # Replace with function body.


func _on_back_pressed():
	
	step -= 1
	
	pass # Replace with function body.


func _on_option_button_item_selected(index):
	
	if index == 0:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	if index == 1:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	if index == 2:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	
	
	pass # Replace with function body.

func _filter(new_text, path):
	var _filtering_input = false
	if _filtering_input:
		return
	var regex := RegEx.new()
	regex.compile("[^0-9]")   # match any non-digit
	var filtered: String = regex.sub(new_text, "", true)
	if filtered != new_text:
		_filtering_input = true
		path.text = filtered
		_filtering_input = false

func _on_x_resolution_edit_text_changed(new_text):
	_filter(new_text, $VideoButtons/XResolutionEdit)
	pass # Replace with function body.

func _on_y_resolution_edit_text_changed(new_text):
	_filter(new_text, $VideoButtons/YResolutionEdit)
	pass # Replace with function body.

func _on_detect_pressed():
	var current_screen = DisplayServer.window_get_current_screen()
	var screen_size = DisplayServer.screen_get_size(current_screen)
	
	$VideoButtons/XResolutionEdit.text = str(screen_size.x)
	$VideoButtons/YResolutionEdit.text = str(screen_size.y)
	pass # Replace with function body.


func _on_apply_pressed():
	if $VideoButtons/XResolutionEdit.text == "" and $VideoButtons/YResolutionEdit.text == "":
		DisplayServer.window_set_size(Vector2i(1152, 648))
	elif $VideoButtons/XResolutionEdit.text == "":
		DisplayServer.window_set_size(Vector2i(1152, Global.size_y))
	elif $VideoButtons/YResolutionEdit.text == "":
		DisplayServer.window_set_size(Vector2i(Global.size_x, 648))
	else:
		DisplayServer.window_set_size(Vector2i(Global.size_x, Global.size_y))
	pass # Replace with function body.


func _on_check_button_toggled(toggled_on):
	Global.damagenumbers = toggled_on
	pass # Replace with function body.
