/*
	Author: Genesis

	Description:
		Function returns nearest "known" enemy for a group - sorted by known accuracy of units position.

	Parameter(s):
		0: GROUP

	Returns:
		nil
*/

private _leader = leader _this;

private _NearTargets = _leader nearEntities ["CAManBase", 1000] select {[side _leader, side _x] call BIS_fnc_sideIsEnemy} apply {[_x distance2D _leader, _x]};

_NearTargets sort true;

_NearTargets