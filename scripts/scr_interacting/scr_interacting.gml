function scr_interacting(){

if akey
{
	switch face
	{
		case 1:
				instance_create_depth(x,y+16,0,obj_interacting);
			break;
		case 2:
				instance_create_depth(x-16,y,0,obj_interacting);
			break;
		case 3:
				instance_create_depth(x,y-16,0,obj_interacting);
			break;
		case 4:
				instance_create_depth(x+16,y,0,obj_interacting);
			break;
	}
}
}