//技能表格枚举
enum DS_SKILL
{
	NAME = 0,
	S_ID = 1,
	SOURCE_COUNT = 2
}

/// @param id
function skill_id(_id){
var _s_name = "???";
var _descr = "???";
//todo:更多技能的详细数据
switch(_id)
{
	default: 
		break;
	
	case 1:
		_s_name = "徒手攻击";
		_descr = "直接用拳头、脚踢或肘击痛殴敌人。";
		break;
	
	case 1001:
		_s_name = "挥打";
		_descr = "用短棍痛殴敌人。";
		break;
	
	case 1010:
		_s_name = "射击";
		_descr = "用轻弩射击敌人。";
		break;
}
return {
	s_name			: _s_name,
	s_id			: _id,
	descr			: _descr
};
}

//增加技能
function add_skill_id(_id,_chara){
var _skill = skill_id(_id);
var _skill_list_h = ds_grid_height(_chara.skill_list);

//情况1，角色已经获得该技能
for(var _i=0;_i<_skill_list_h;_i++)
{
	if(ds_grid_get(_chara.skill_list,DS_SKILL.S_ID,_i) == _id)
	{
		ds_grid_set(_chara.skill_list,DS_SKILL.SOURCE_COUNT,_i,ds_grid_get(_chara.skill_list,DS_SKILL.SOURCE_COUNT,_i)+1);
		return true;
	}
}

//情况2，角色还不会该技能
//如果表格有内容，就扩展一行
if (ds_grid_get(_chara.skill_list,0,0)!=0)
{
	ds_grid_resize(_chara.skill_list,skill_w,ds_grid_height(_chara.skill_list)+1);
}
var _new_skill = ds_grid_height(_chara.skill_list)-1;
ds_grid_set(_chara.skill_list,DS_SKILL.NAME,_new_skill,_skill.s_name);
ds_grid_set(_chara.skill_list,DS_SKILL.S_ID,_new_skill,_skill.s_id);
ds_grid_set(_chara.skill_list,DS_SKILL.SOURCE_COUNT,_new_skill,1);
return true;
}

//删除技能
function remove_skill_id(_id,_chara){
if (!ds_exists(_chara.skill_list, ds_type_grid))
{
	return false;
}
var _skill_list_h = ds_grid_height(_chara.skill_list);

for (var _i = 0; _i < _skill_list_h; _i++)
{
	if (ds_grid_get(_chara.skill_list, DS_SKILL.S_ID, _i) == _id)
	{
		var _src = ds_grid_get(_chara.skill_list, DS_SKILL.SOURCE_COUNT, _i) - 1;
		
		//还有来源，只减数量
		if (_src > 0)
		{
			ds_grid_set(_chara.skill_list, DS_SKILL.SOURCE_COUNT, _i, _src);
			return true;
		}
		
		//来源为0，删除该行
		var _from = _i + 1;
		var _to = _i;
		for (var r=_to;r<_skill_list_h-1;r++)
		{
			ds_grid_set_grid_region(_chara.skill_list,_chara.skill_list,0,_from,skill_w-1,_from,0,r);
			_from += 1;
		}
		ds_grid_resize(_chara.skill_list,skill_w,_skill_list_h-1);
		_skill_list_h--;
		return true;
	}
}

// 没找到技能
return false;
}