switch global.warping
{
case 0:
		instance_destroy(self);
	break;
case 1:
		warp_i+=1;
	break;
case 2:
		warp_i-=1;
	break;
}

if warp_i > 14
{
	global.warping = 2;
}
if warp_i < 1
{
	global.warping = 0;
}