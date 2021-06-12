#include "macros.hpp"

params ["_obj"];

private _hcOwner = owner HC1;
private _currentOwner = owner _obj;
if (_hcOwner == 0 || isNull _obj || _hcOwner == _currentOwner) exitWith {};

private _changed = false;
private _group = group _obj;

["HC", "TRANSFER", [_obj, local _obj, _group, !isNull _group]] call OPT_LOGGING_fnc_writelog;

if (!isNull _group) then {
    _changed = _group setGroupOwner (owner HC1);
} else {
    _changed = _obj setOwner (owner HC1);
};

private _sourceName = "N/A";
private _targetName = "N/A";
{
    if (owner _x == _currentOwner) then {
        _sourceName = name _x;
    };
    if (owner _x == _hcOwner) then {
        _targetName = name _x;
    };
} forEach allPlayers;

["HC", "TRANSFER_2", [format ["From '%1' to '%2'", _sourceName, _targetName], _changed]] call OPT_LOGGING_fnc_writelog;
