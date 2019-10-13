#include "macros.hpp"

["missionStarted", {
    // Create markers for all players already here in case of JIP
    DUMP("Adding initial unit icons...");
    allPlayers apply {
        DUMP(_x);
        DUMP([_x] call FUNC(isUnitVisible));
        if (CLib_Player != _x && [_x] call FUNC(isUnitVisible) ) then {
            [_x] call FUNC(addUnitToGPS);
            DUMP((CGVAR(MapGraphics_MapGraphicsGroup) call CFUNC(allVariables)) select {(_x find toLower QGVAR(IconId)) == 0});
        };
    };

    // We have to register the UAV dialog every time the map is opened/closed
    addMissionEventHandler ["Map", {
        params ["_mapIsOpened", "_mapIsForced"];
        DUMP("Map opened");

        if (_mapIsOpened) then {
            // UAV
            if (!isNull (findDisplay 160 displayCtrl 51)) exitWith {
                DUMP("UAV dialog found");
                DUMP((findDisplay 160) displayCtrl 51);
                (findDisplay 160 displayCtrl 51) call CFUNC(registerMapControl);
            };
        };
    }];
    
    // The same goes for GPS. This should already work out of the box with CLib, but there seem to be weird cases breaking this.
    // TODO: Monitor if this actually solves the issue! If not, revisit/remove it.
    ["visibleGPSChanged", {
        if (GVAR(GPSMapCheckRunning)) exitWith {};
        GVAR(GPSMapCheckRunning) = true;
        [{
            DUMP("GPS detected");
            GVAR(GPSMapCheckRunning) = false;
            ((uiNamespace getVariable "RscCustomInfoMiniMap") displayCtrl 101) call CFUNC(registerMapControl);
        }, {!(isNull (uiNamespace getVariable "RscCustomInfoMiniMap"))}] call CFUNC(waitUntil);
    }] call CFUNC(addEventhandler);

    // TODO: Is there a better way to deal with artillery computers?
    // For now, we use perFrame with a 1sec delay. This shouldn't be too painful for clients.
    [{
        if (shownArtilleryComputer) then {
            if (!isNull (findDisplay -1 displayCtrl 500) && (isNil {uinamespace getVariable QGVAR(artilleryComputerOpen)})) then {
                uiNamespace setVariable [QGVAR(artilleryComputerOpen), true];
                DUMP("Artillery dialog found");
                DUMP((findDisplay -1) displayCtrl 500);
                (findDisplay -1 displayCtrl 500) call CFUNC(registerMapControl);
            };
        } else {
            if (!isNil {uinamespace getVariable QGVAR(artilleryComputerOpen)}) then {
                DUMP("Artillery dialog REMOVED");   
                (findDisplay -1 displayCtrl 500) call CFUNC(unregisterMapControl);
                uinamespace setVariable [QGVAR(artilleryComputerOpen), nil];
            };
        };
    }, 1] call CFUNC(addPerFrameHandler);

}] call CFUNC(addEventhandler);
