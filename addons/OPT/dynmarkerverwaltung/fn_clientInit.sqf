/**
* Dynamische Markerverwaltung, erstellen und verwalten der Anforderungen aus den Einzelfunktionen 
* 
* Autor: [GNC]Lord-MDB
*
* Argumente:
* keine
*
* Rückgabewert:
* Rückgabewert mit <TYP> und Beschreibung 
*
* Server Only:
* Nein
* 
* 
* Lokal:
* Ja/Nein
* Lokal bedeutet, dass das Skript keine globalen Variablen o.Ä. verändert/erstellt. 
* Wenn Nein und es bestehen Einflüsse auf andere Skripte hier kurz beschreiben.
* 
* Global:
* Nein
* 
*
*
* API:
* Ja
* 
* 
* Beispiel Externer Aufruf:
* <Rückgabewert> = [<Argumente>] call EFUNC(Modul,Funktion);
* Beispiel interner Aufruf:
* <Rückgabewert> = [<Argumente>] call FUNC(Funktion);
*
*/

#include "macros.hpp"

diag_log "Successfully loaded the OPT/dynmarkerverwaltung module on the client";

//Texturverweise

//Spieler Marker
#define player_icon "\A3\ui_f\data\map\vehicleicons\iconMan_ca.paa"

//Revive Marker
#define revive_icon "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa"

//Heli Marker
#define heli_icon "\A3\ui_f\data\map\vehicleicons\iconHelicopter_ca.paa"

//Flugzeuge Marker
#define flug_icon "\A3\ui_f\data\map\vehicleicons\iconPlane_ca.paa"

//Panzer Marker
#define panzer_icon "\A3\ui_f\data\map\vehicleicons\iconTank_ca.paa"

//Fallschirm Marker
#define fallschirm_icon "\A3\ui_f\data\map\vehicleicons\iconParachute_ca.paa"

//Dialoge zum Overlay hinzufügen für Darstellung
GVAR(dialogCheck) = 
[
	{
		//OPT Karten-Dialog
		if (!(isNull ((findDisplay 444001) displayCtrl 10007))) then
		{
			((findDisplay 444001) displayCtrl 10007) call CFUNC(registerMapControl);
			[{}, {(isNull ((findDisplay 444001) displayCtrl 10007))}] call CFUNC(waitUntil);	
		};

		//BIS Artillery Dialog
		if (!(isNull ((findDisplay -1) displayCtrl 500))) then
		{
			((findDisplay -1) displayCtrl 500) call CFUNC(registerMapControl);
			[{}, {(isNull ((findDisplay -1) displayCtrl 500))}] call CFUNC(waitUntil);	
		};

		//BIS  UAV Dialog (klappt nicht)
		if (!(isNull ((findDisplay 160) displayCtrl -1))) then
		{
			((findDisplay 160) displayCtrl -1) call CFUNC(registerMapControl);
			[{}, {(isNull ((findDisplay 160) displayCtrl -1))}] call CFUNC(waitUntil);	
		};

	}, 0, []
	
] call CFUNC(addPerFrameHandler);

//alte Marker löschen
DFUNC(markerloeschen) = 
{
	params 
	[
		["_id",""],
	];
	
	_id apply 
	{ 

		[_x] call CFUNC(removeMapGraphicsGroup);

	};	

};

//Initialisierung
["missionStarted", 
{
	GVAR(Marker) = [];

	//Gobalenarray verarbeiten und ausführen
	GVAR(gobalerMarkerArray) = 
	[
		{
			/* PARAMS */

			params
			[
				["_params",[]],
				["_nr",0]
			];

			if (count GVAR(Marker) > 0) then  
			{
				[GVAR(Marker)] call FUNC(markerloeschen);
			};	

			_params apply 
			{ 
				_x params
				[
					["_id",""],
					["_type",""],
					["_farbe",[]],
					["_text",""],
					["_sichtbarkeit",1],
					["_position",[]],
					["_winkel",0]
				];

				switch (_type) do 
				{
					case "Spieler": 
					{
						private _marker = ["ICON", player_icon, _farbe, _position, 20, 20, _winkel, _text, _sichtbarkeit, 0.08, "RobotoCondensed", "right"];	
					}; 

					case "Revive": 
					{
						private _marker = ["ICON", revive_icon, _farbe, _position, 20, 20, _winkel, _text, _sichtbarkeit, 0.08, "RobotoCondensed", "right"];	
					}; 

					case "Heli": 
					{
						private _marker = ["ICON", heli_icon, _farbe, _position, 20, 20, _winkel, _text, _sichtbarkeit, 0.08, "RobotoCondensed", "right"];	
					};  

					case "Flugzeuge": 
					{
						private _marker = ["ICON", flug_icon, _farbe, _position, 20, 20, _winkel, _text, _sichtbarkeit, 0.08, "RobotoCondensed", "right"];	
					};    

					case "Panzer": 
					{
						private _marker = ["ICON", panzer_icon, _farbe, _position, 20, 20, _winkel, _text, _sichtbarkeit, 0.08, "RobotoCondensed", "right"];	
					}; 

					case "Fallschirm": 
					{
						private _marker = ["ICON", fallschirm_icon, _farbe, _position, 20, 20, _winkel, _text, _sichtbarkeit, 0.08, "RobotoCondensed", "right"];	
					};    

					default 
					{
					};
				};	

				// Sammelarray Marker
				GVAR(Marker) pushBack _id;

				[_id, [_marker]] call CFUNC(addMapGraphicsGroup);

			};	

		}, 0, []
		
	] call CFUNC(addPerFrameHandler);

  	
}, []] call CFUNC(addEventHandler); 


