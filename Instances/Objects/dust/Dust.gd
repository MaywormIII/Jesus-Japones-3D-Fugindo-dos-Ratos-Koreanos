extends Spatial

var myMat = null
var z1 = 0
var indo = true
var lock = false
func _ready():
	
	myMat = preload("Dust.material").duplicate()
	
	
	
	set_process(true)
	
func _process(delta):
	if(!lock):
		translation += Vector3(randi() %10 -5, randi() %10 -5, randi() %10 -5)/8
		lock = true
	translation.y += 0.05+z1/20
	if indo:
		z1+=5*delta
		if z1>1:indo = false
		translation.x+=z1/10
	else:
		z1-=5*delta
		if z1<-1:indo = true
		translation.x-=z1/10
	scale = scale.normalized() * (scale.length() + .01)
	myMat.albedo_color.a -= 0.5*delta
	if myMat.albedo_color.a <= 0:
		queue_free()
