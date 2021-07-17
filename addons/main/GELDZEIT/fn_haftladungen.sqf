/**
* Description:
* Stellt Haftladungen zur Verfügung
* 
* Author: Lord-MDB
* 
* Arguments:
* none
*
* Return Value:
* None
*
*
* Server only:
* no
*
* Global:
* no
* 
* Public:
* no
*
* Example:
* [] call func(haftladungen);
*/
#include "macros.hpp"

private _pic = "A3\Weapons_F\Data\UI\gear_c4_charge_small_CA.paa";

// Fahrzeug und Bomben ermittlung 
private _veh = nearestObjects[player, ["car", "truck", "tank", "wheeled_apc"], 8] select 0;
private _bomb = nearestObject [player, 'PipeBombBase'];

// Check ob Beide nötigen Dinge vorhanden sind
if (isNull _veh) exitWith {hint format["%1", MLOC(HAFTLADUNGNOVEH)];};
if (isNull _bomb) exitWith {hint format["%1", MLOC(HAFTLADUNGNOBOMBE)];};

if ((_bomb distance _veh) > 8) exitWith {hint format["%1", MLOC(HAFTLADUNGNOBOMBE)];};

// Roherfassung Objekt
private _start = AGLToASL positionCameraToWorld [0, 0, 0];
private _end = AGLToASL positionCameraToWorld [0, 0, 10];
private _lis = lineIntersectsSurfaces [_start, _end, player, objNull, true, -1];
private _intersection = _lis param [0, []] select 0;

// Check ob Fahrzeug gefunden wurde
if (isNil "_intersection") exitWith {hint format["%1",MLOC(HAFTLADUNGNOVEH)];};
if (_intersection isEqualTo []) exitWith {hint format["%1",MLOC(HAFTLADUNGNOVEH)];};

// Netto Position des Fahrzeugs
private _vDir = _start vectorFromTo _end;
private _position = _intersection vectorAdd (_vDir vectorMultiply + (0.9 * abs(cos(getDir _veh + 90)))); // 90 cm abstand 
private _offset = _veh worldToModel ASLToAGL _position;

private _xoffset = _offset select 0;
private _yoffset = _offset select 1;
private _zoffset = _offset select 2;

// Anheften der Sprengladung mit Offset
_bomb attachTo [_veh, [_xoffset, _yoffset, _zoffset]];

// Ausrichten der Sprengladung 
private _unitdir = getDir player;
_bomb setVectorDirAndUp [[0, (cos(getDir _veh + 90)), 0], [(cos(getDir _veh - 90 + _unitdir)), (cos(getDir _veh + 90 + _unitdir)), 0]];

// Ausgabe an den Spieler
_pic = "A3\Weapons_F\Data\UI\gear_c4_charge_small_CA.paa";
hint composeText [parseText format ["<t align='left' size='%4'><img image='%3'></t>" +"<t align='center' size='1.25' shadow='true'>%1</t><t align='right' size='%4'><img image='%3'></t>" +"<br/>" +"<t align='center' size='1.0' shadow='true'>%2</t>","C4",MLOC(HAFTLADUNGATTACH),_pic,3.0]];
