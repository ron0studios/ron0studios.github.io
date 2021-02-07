extends Line2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var connect_from
var connect_to

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _movepoints(amt):
	for i in self.gradient.offsets:
		i += amt
	pass

func greyout(a, b, c = 1):
	$Tween.interpolate_property(self, "modulate", Color(a,a,a,1), Color(b,b,b,1), c,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start() 

func flash():
	$Tween.interpolate_property(self, "modulate", Color(0,0,0,1), Color(1,1,1,1), 0.5,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start() 
	#$Tween.interpolate_method(self, "_movepoints", 0, 1, 1,Tween.TRANS_LINEAR,Tween.EASE_IN)
	#$Tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $triangle.modulate.a == 0:
		$triangle.modulate.a = 1;
	if not connect_to is Vector2:
		if connect_to == null or connect_from == null:
			if connect_to == null: 
				var toremove=[] #queue deletion
				for i in range(len(connect_from.connections)):
					if connect_from.connections[i] == null:
						toremove.append(i)
						#connect_from.connections.remove(i)
				for i in toremove:
					connect_from.connections.remove(i)
			self.queue_free()
			pass
		if not self.is_queued_for_deletion():
			points[1] = connect_to.rect_global_position - connect_from.rect_global_position
			points[1] += Vector2(16,16)
			points[1] -= Vector2(24,0).rotated(get_angle_to(connect_to.rect_global_position))
			$triangle.position = points[1] #- Vector2(24,0).rotated(get_angle_to(connect_to.rect_global_position))
			$triangle.rotation = deg2rad(90) + get_angle_to(connect_to.rect_global_position)
	else:
		points[1] = get_local_mouse_position()
		#points[1] -= Vector2(24,0).rotated(get_angle_to(get_global_mouse_position()))
		$triangle.position = points[1] - Vector2(0,0).rotated(get_angle_to(get_global_mouse_position()))
		$triangle.rotation = deg2rad(-90) + (self.global_position + Vector2(16,16)).angle_to_point(get_global_mouse_position()) 
	pass
