extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal initconnections
var holding = false
var holdarrow
var layers = 2
var height = 3

func shuffled(x):
	var a = x
	a.shuffle()
	return a

func _addvertice(posx,posy, value=-1):
		var vertice = load("res://graphnode.tscn").instance()
		vertice.value = value
		$nodes.add_child(vertice)
		vertice.rect_global_position = Vector2(posx,posy)

func _gentree(length):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	#neural network style
	#_addvertice(-100,(height*100)/2 -50)
	#for i in range(layers):
	#	for j in range(height):
	#		_addvertice(i*100, j*100)
	#_addvertice(layers*100, (height*100)/2 -50 )
	
	for i in range(10):
		_addvertice(i*100, (i%3)*100, i+1)
	
	#the following adds "x" amount of connections
	var connected = []
	for i in $nodes.get_children():
		self.connect("initconnections",i, "init_edges")
		for j in shuffled($nodes.get_children()):
			randomize()
			if j != i and not i in j.connections and len(i.connections) < 1 and not j in connected: # x is the "< 2" part
				connected.append(j)
				i.connections.append(j)
	emit_signal("initconnections")
	#calculate($nodes.get_child(0)) # 0 for now

	pass # Replace with function body.

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		holding = false
		if holdarrow:
			holdarrow.queue_free()


func dfs(start, explored=[]):
	var root = false
	if explored == []:
		root = true
	yield(get_tree().create_timer(1), "timeout")
	start.flash()
	explored.append(start)
	for i in range(2, len(start.get_children())):
		if not start.get_children()[i].connect_to in explored:
			yield(get_tree().create_timer(1), "timeout")
			start.get_children()[i].greyout(1,0.5, 0.5)
			yield(dfs(start.get_children()[i].connect_to, explored),"completed")
			yield(get_tree().create_timer(1), "timeout")
			start.get_children()[i].greyout(0.5,1, 0.5)
	if root == true:
		yield(get_tree().create_timer(5), "timeout")
		for i in $nodes.get_children():
			i.self_modulate = Color(1,1,1,1)
	pass


func _on_ColorRect_gui_input(event):
	if event is InputEventMouseButton:
		if event.doubleclick and event.button_index == BUTTON_LEFT:
			var vertice = load("res://graphnode.tscn").instance()
			vertice.value = $nodes.get_child_count()+1
			$nodes.add_child(vertice)
			vertice.rect_global_position = get_global_mouse_position() - Vector2(16,16)
	pass # Replace with function body.


func _on_HSlider_value_changed(value):
	Engine.time_scale = value
	pass # Replace with function body.
