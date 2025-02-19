params ["_vehicle",["_force",false]];

if(_force) exitWith {
	{
		if !(_x call OT_fnc_hasOwner) then {
			deleteVehicle _x;
		};
	}foreach(crew _vehicle);
	if !(_vehicle call OT_fnc_hasOwner) then {
		deleteVehicle _vehicle;
	};
};

if(_vehicle isEqualType grpNull) exitWith {
	if(count (units _vehicle) isEqualTo 0) exitWith {deleteGroup _vehicle};
	private _l = (units _vehicle) select 0;
	[{!((_this#0) call OT_fnc_inSpawnDistance) || _force}, {
		_vehs = [];
		_this params ["_l","_vehicle"];
		{
			if(!isNull objectParent _x) then {_vehs pushBackUnique (objectParent _x)};
			if !(_x call OT_fnc_hasOwner) then {
				if (isNull objectParent _x) then {
					deleteVehicle _x;
				} else {
					[(objectParent _x), _x] remoteExec ["deleteVehicleCrew", _x, false];
				};
			};
		}foreach(units _vehicle);
		{
			deleteVehicle _x;
		}foreach(_vehs);
		deleteGroup _vehicle;
	}, [(units _vehicle) select 0,_vehicle]] call CBA_fnc_waitUntilAndExecute;
};

if(_vehicle getVariable ["OT_cleanup",false]) exitWith {};

_vehicle setVariable ["OT_cleanup",true,false];

if(OT_adminMode) then {
	diag_log format["Overthrow: cleanup called on %1",typeOf _vehicle];
};

[{!((_this select 0) call OT_fnc_inSpawnDistance)}, {
	_this params ["_vehicle"];
	if(_vehicle isKindOf "CAManBase") then {
		if(!isNull objectParent _vehicle) then {[(objectParent _vehicle)] call OT_fnc_cleanup};
	}else{
		{
			if !(_x call OT_fnc_hasOwner) then {
				[(objectParent _x), _x] remoteExec ["deleteVehicleCrew", _x, false];
			};
		}foreach(crew _vehicle);
	};
	if !(_vehicle call OT_fnc_hasOwner) then {
		deleteVehicle _vehicle;
	};
}, [_vehicle]] call CBA_fnc_waitUntilAndExecute;
