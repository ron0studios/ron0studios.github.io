extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var check = false
var followmouse = false
var connections = []
var value = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.

func flash():
	$Tween.interpolate_property(self, "self_modulate", Color(1,1,1,1), Color(0.5,0.5,0.5,1), 0.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start() 
	#$Tween.interpolate_property(self, "self_modulate", Color(1,0,0,1), Color(1,1,1,1), 0.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	#$Tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Label.text = str(value)
	if Input.is_action_just_pressed("rmb") and check:
		if not get_parent().get_parent().holding:
			var edge = load("res://edge.tscn").instance()
			edge.connect_from = self
			edge.connect_to = get_global_mouse_position() 
			add_child(edge)
			get_parent().get_parent().holding = true
			get_parent().get_parent().holdarrow = edge
		else:
			if not get_parent().get_parent().holdarrow.connect_from == self:
				get_parent().get_parent().holding = false
				get_parent().get_parent().holdarrow.connect_to = self
				get_parent().get_parent().holdarrow.connect_from.connections.append(self)
			
			
	if check and Input.is_action_pressed("lmb"):
		followmouse = true
	if Input.is_action_just_released("lmb") and followmouse:
		followmouse = false
	if followmouse:
		set_position(get_global_mouse_position() - Vector2(16,16))
	pass

func init_edges():
	for i in connections:
		var edge = load("res://edge.tscn").instance()
		edge.connect_from = self
		edge.connect_to   = i
		add_child(edge)
	pass

func _on_Panel_mouse_entered():
	if not Input.is_action_pressed("lmb"):
		check = true
	pass # Replace with function body.


func _on_Panel_mouse_exited():
	check = false
	pass # Replace with function body.


func _on_Panel_gui_input(event):
	if Input.is_action_just_pressed("mmb"):
		get_parent().get_parent().dfs(self)
	if event is InputEventMouseButton:
		if event.doubleclick  and event.button_index == BUTTON_LEFT:
			self.queue_free()
	pass # Replace with function body.




func _on_Tween_tween_all_completed():
	#$Tween.interpolate_property(self, "self_modulate", Color(1,1,1,1), Color(0.5,0.5,0.5,1), 1,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	#$Tween.start() 
	$Tween.disconnect("tween_all_completed",self,"_on_Tween_tween_all_completed")
	pass # Replace with function body.
