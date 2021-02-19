extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal initconnections
var holding = false
var holdarrow
var layers = 2
var height = 3
var paused

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

func common_data(list1, list2): 
	var result = false

	for x in list1:
		for y in list2: 
			if x == y: 
				result = true
				return result  

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	for i in range(int(rand_range(3,10))):
		_addvertice(rand_range(50,900), rand_range(50,550), i+1)
	for i in $nodes.get_children():
		for j in shuffled($nodes.get_children()):
			randomize()
			if j != i and len(i.connections ) < 1:
				var edge = load("res://edge.tscn").instance()
				edge.connect_from = i
				edge.connect_to = j
				var l1 = []
				for el in j.connections:
					l1.append(el.connect_to)
				if not i in l1:
					i.add_child(edge)
					i.connections.append(edge)
					j.connections_from.append(edge)
				if false:
					pass
				
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
		if not start.get_children()[i].connect_to in explored or $viewpoint/GUI/CheckButton.pressed:
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

func bfs(start, queue=[], visited=[]):
	queue.append(start)
	visited.append(start)
	while len(queue) > 0:
		yield(get_tree().create_timer(1), "timeout")
		var pop = queue.pop_front()
		pop.flash()
		for i in range(2,len(pop.get_children())):
			yield(get_tree().create_timer(0.5), "timeout")
			if not pop.get_children()[i].connect_to in visited:
				pop.get_children()[i].connect_to.flash(5,0.0,0.0)
				queue.append(pop.get_children()[i].connect_to)
				visited.append(pop.get_children()[i].connect_to)
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
