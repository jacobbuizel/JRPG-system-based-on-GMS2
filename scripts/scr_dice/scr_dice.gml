/// @param number
/// @param dice
function dice(_num,_dice){
randomise()
var _return_num = 0;
for(var i=1;i<=_num;i++)
{
	_return_num += irandom_range(1,_dice);
}
return _return_num;
}

/// @param advantages*
function d20c(){
randomise()
var _return_num = dice(1,20);
if argument_count>0
{
	var _d1 = dice(1,20);
	var _d2 = dice(1,20);
	switch argument[0]
	{
		case -1:
			_return_num = min(_d1,_d2);
			break;
		case 0:
			_return_num = dice(1,20);
			break;
		case 1:
			_return_num = max(_d1,_d2);
			break;
	}
}
return _return_num;
}