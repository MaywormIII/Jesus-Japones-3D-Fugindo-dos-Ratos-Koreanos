extends KinematicBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

enum State {
	ACTIVE,
	HANGING
}

var currentAnim = null
var facing = Vector3(0, 0, -1)

var moveVec = Vector3()
var tiltVec = Vector3()
var analogVec = Vector3()

var airAccelRate = 0.25
var maxSpd = 3
var friction = 2
var accelRate = 2 + friction
var gravity = 1.2
var jumpSpd = 26
var coyoteJump = null
var wasOnFloor = false
var state = State.ACTIVE
var hangingFrom = null
var letGoPosition = Vector3()
var zLook = 100
func spawnDust():		# Spawn dust function
	$DustSpawner.spawnDust()

func _ready():
	coyoteJump = get_node("CoyoteJump")
	
func _physics_process(delta):
	
	var mv = Vector3()

	var diff = get_node("../Player").translation - translation
	diff.y = 0
	if(diff.length()>0.3 and diff.length()<20):
		mv += diff
		mv = mv.normalized()
		moveVec += mv * accelRate

	look_at(Vector3(get_node("../Player").translation.x,
		get_node("../Player").translation.y+zLook,
		get_node("../Player").translation.z)
		,Vector3(0,1,0))
	if(diff.length()<15):
		if(zLook>0):
			zLook-=delta*100
	elif(zLook<100):
			zLook+=delta*50
	if(diff.length()<1):
#		if(get_node("../Player").maxSpd>maxSpd*1.1):
		get_node("../Player").maxSpd -= 1*delta
	if moveVec.length() > maxSpd:
		moveVec = moveVec.normalized() * maxSpd
	
	moveVec = move_and_slide(moveVec, Vector3(0, 1, 0), 0)
	

