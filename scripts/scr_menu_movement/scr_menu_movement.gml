function scr_menu_movement_jump(_inst,_ref_pos,_ref_scroll_a,_ref_height,_ref_end,_jump,_dir,_loop) {
	var _pos = 0;
	var _scroll_a = 0;
	
	//获取取选框位置
	if (variable_global_exists(_ref_pos))
	{
		_pos = variable_global_get(_ref_pos);
	}
	else
	{
		_pos = variable_instance_get(_inst, _ref_pos);
	}
	
	//获取滚动位置
	if (_ref_scroll_a != "" && _ref_scroll_a != undefined)
	{
		if (variable_global_exists(_ref_scroll_a))
		{
			_scroll_a = variable_global_get(_ref_scroll_a);
		}
		else
		{
			_scroll_a = variable_instance_get(_inst, _ref_scroll_a);
		}
	}
	
	if _dir>0
	{
		//向下跳选
		if _pos + _jump <= _ref_end - 1
		{
			_pos += _jump;
		}
		else if _pos + _scroll_a + _jump <= _ref_height-1
		{
			_scroll_a += _jump-(_ref_end - 1 - _pos);
			_pos = _ref_end - 1;
		}
		else if _pos + _scroll_a < _ref_height-1
		{
			_pos = _ref_end - 1;
			_scroll_a = max(0, _ref_height - _ref_end);
		}
		else
		{
			if _loop
			{
				_scroll_a = 0;
				_pos = 0;
			}
		}
	}
	else
	{
		//向上跳选
		if _pos - _jump >= 0
		{
			_pos -= _jump;
		}
		else if _pos + _scroll_a - _jump >= 0
		{
			_scroll_a -= _jump - _pos;
			_pos = 0;
		}
		else if _pos + _scroll_a > 0
		{
			_scroll_a = 0;
			_pos = 0;
		}
		else
		{
			if _loop
			{
				_pos = _ref_end - 1;
				_scroll_a = max(0, _ref_height - _ref_end);
			}
		}
	}
	
	//写回
    if (variable_global_exists(_ref_pos))
	{
        variable_global_set(_ref_pos, _pos);
    }
	else
	{
        variable_instance_set(_inst, _ref_pos, _pos);
    }

	if (_ref_scroll_a != "" && _ref_scroll_a != undefined)
	{
	    if (variable_global_exists(_ref_scroll_a))
		{
	        variable_global_set(_ref_scroll_a, _scroll_a);
	    }
		else
		{
	        variable_instance_set(_inst, _ref_scroll_a, _scroll_a);
	    }
	}
}