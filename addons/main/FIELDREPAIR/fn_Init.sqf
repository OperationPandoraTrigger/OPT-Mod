/**
* Description:
* Initializes Vars für Client und Server
*
* Author:
* [GNC]Lord-MDB
*
* Arguments:
*
* Return Value:
*
* Server Only:
* no
*
* Global:
* yes
*
* API:
* No
*
* Example:
*/
#include "macros.hpp"

GVAR(repairHitPoints) = ["HitLFWheel", "HitLBWheel", "HitLMWheel", "HitLF2Wheel", "HitRFWheel", "HitRBWheel", "HitRMWheel","HitRF2Wheel", "HitEngine", "HitLTrack","HitRTrack", "HitHull", "HitWinch"] + ["HitEngine1", "HitEngine2", "HitEngine3", "HitFuel", "HitAvionics", "HitVRotor", "HitHRotor", "HitHydraulics", "HitGear", "HitTail", "HitPitotTube", "HitStaticPort"];
GVAR(hardRepairParts) = ["HitEngine", "HitLTrack", "HitRTrack", "HitHull"] + ["HitEngine1", "HitEngine2", "HitEngine3", "HitFuel", "HitAvionics", "HitHRotor", "HitHydraulics", "HitGear", "HitTail"];
GVAR(repairClasses) = ["OPT_O_T_Truck_02_box_F", "OPT_O_Truck_03_repair_F", "OPT_O_T_Truck_03_repair_ghex_F", "OPT_B_Truck_01_Repair_F", "OPT_B_Truck_01_Repair_ghex_F", "OPT_I_Truck_02_box_F", "OPT_B_Slingload_01_Repair_F", "OPT_O_Heli_Transport_04_box_F", "OPT_CUP_B_MTVR_Repair_USMC", "OPT_CUP_O_Ural_Repair_TKA"]
