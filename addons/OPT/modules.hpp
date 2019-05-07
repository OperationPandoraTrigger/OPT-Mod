// include the required addons directly from CLib
#include "\tc\CLib\addons\CLib\ModuleMacros.hpp"

class CfgCLibModules 
{
    class PREFIX 
	{
        path = "OPT\OPT\addons\OPT";
		
		dependency[] = {};
		
		MODULE(gps) 
		{

			dependency[] = {"CLib/PerFrame", "Clib/Events"};
			
			FNC(clientInit);
		};
		
		MODULE(radar) 
		{

			dependency[] = {"CLib/PerFrame", "Clib/Events"};
			
			FNC(clientInit);
		};
		
		MODULE(dynmarkerverwaltung) 
		{

			dependency[] = {"CLib/PerFrame", "Clib/Events"};
			
			FNC(clientInit);
		};
		
    };
};