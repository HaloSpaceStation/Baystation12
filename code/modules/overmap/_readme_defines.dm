/*
The overmap system allows adding new maps to the big 'galaxy' map.
Idea is that new sectors can be added by just ticking in new maps and recompiling.
Not real hot-plugging, but still pretty modular.
It uses the fact that all ticked in .dme maps are melded together into one as different zlevels.
Metaobjects are used to make it not affected by map order in .dme and carry some additional info.

*************************************************************
Metaobject
*************************************************************
/obj/effect/zlevelinfo, sectors.dm
Used to build overmap in beginning, has basic information needed to create overmap objects and make shuttles work.
Its name and icon (if non-standard) vars will be applied to resulting overmap object.
'mapy' and 'mapx' vars are optional, sector will be assigned random overmap coordinates if they are not set.
Has two important vars:
	obj_type	-	type of overmap object it spawns. Could be overriden for custom overmap objects.
	landing_area -	type of area used as inbound shuttle landing, null if no shuttle landing area.

Object could be placed anywhere on zlevel. Should only be placed on zlevel that should appear on overmap as a separate entitety.
Right after creation it sends itself to nullspace and creates an overmap object, corresponding to this zlevel.

*************************************************************
Overmap object
*************************************************************
/obj/effect/overmapobj, sectors.dm
Represents a zlevel on the overmap. Spawned by metaobjects at the startup.
	var/area/shuttle/shuttle_landing - keeps a reference to the area of where inbound shuttles should land

-CanPass should be overriden for access restrictions
-Crossed/Uncrossed can be overriden for applying custom effects.
Remember to call ..() in children, it updates ship's current sector.

subtype /ship of this object represents spacefaring vessels.
It has 'current_sector' var that keeps refernce to, well, sector ship currently in.

*************************************************************
Helm console
*************************************************************
/obj/machinery/computer/helm, helm.dm
On creation console seeks a ship overmap object corresponding to this zlevel and links it.
Clicking with empty hand on it starts steering, Cancel-Camera-View stops it.
Helm console relays movement of mob to the linked overmap object.
Helm console currently has no interface. All travel happens instanceously too.
Sector shuttles are not supported currently, only ship shuttles.

*************************************************************
Exploration shuttle terminal
*************************************************************
A generic shuttle controller.
Has a var landing_type defining type of area shuttle should be landing at.
On initalizing, checks for a shuttle corresponding to this zlevel, and creates one if it's not there.
Changes desitnation area depending on current sector ship is in.
Currently updating is called in attack_hand(), until a better place is found.
Currently no modifications were made to interface to display availability of landing area in sector.


*************************************************************
Guide to how make new sector
*************************************************************
0.Map
Remember to define shuttle areas if you want sector be accessible via shuttles.
Currently there are no other ways to reach sectors from ships.
In examples, 4x6 shuttle area is used. In case of shuttle area being too big, it will apear in bottom left corner of it.

Remember to put a helm console and engine control console on ship maps.
Ships need engines to move. Currently there are only thermal engines.
Thermal engines are just a unary atmopheric machine, like a vent. They need high-pressure gas input to produce more thrust.


1.Metaobject
All vars needed for it to work could be set directly in map editor, so in most cases you won't have to define new in code.
Remember to set landing_area var for sectors.

2.Overmap object
If you need custom behaviour on entering/leaving this sector, or restricting access to it, you can define your custom map object.
Remember to put this new type into spawn_type var of metaobject.

3.Shuttle console
Remember to place one on the actual shuttle too, or it won't be able to return from sector without ship-side recall.
Remember to set landing_type var to ship-side shuttle area type.
shuttle_tag can be set to custom name (it shows up in console interface)

5.Engines
Actual engines could be any type of machinery, as long as it creates a ship_engine datum for itself.

6.Tick map in and compile.
Sector should appear on overmap (in random place if you didn't set mapx,mapy)


TODO:
shuttle console:
	checking occupied pad or not with docking controllers
	?landing pad size detection
non-zlevel overmap objects
	field generator
		meteor fields
			speed-based chance for a rock in the ship
		debris fields
			speed-based chance of
				debirs in the ship
				a drone
				EMP
		nebulaes
*/

//Zlevel where overmap objects should be
#define OVERMAP_ZLEVEL 1

//How far from the edge of overmap zlevel could randomly placed objects spawn
#define OVERMAP_EDGE 7

//largest number of tiles a single "object" can cover on the overmap
//this can be an artbitrary value, it's just defined to make sure cross-sector travel works properly
#define MAX_OVERMAP_DIMS 5

#define PIXEL_KNOCK_SPEED 2.5
#define PIXEL_IMPACT_SPEED 10
#define PIXEL_CRASH_SPEED 32

//asteroid generation
#define BIGASTEROID_STOP 0
#define BIGASTEROID_MASKING 1
#define BIGASTEROID_PICKMORPH 2
#define BIGASTEROID_MORPHING 3
#define BIGASTEROID_SMOOTHING 4
#define BIGASTEROID_SMOOTHING_APPLY 5
#define BIGASTEROID_CAVES_SEED 6
#define BIGASTEROID_CAVES_ITER 7
#define BIGASTEROID_CAVES_ORE 8
#define BIGASTEROID_CAVES_APPLY 9
#define BIGASTEROID_CAVES_VEINS 9
#define BIGASTEROID_CAVES_FINISH 10

#define HUD_CSS_STYLE "text-align:center;vertical-align:middle;font-family:sansserif;font-size:2;font-weight:bold;"
#define HUD_CSS_STYLE_LESSER "text-align:center;vertical-align:middle;font-family:sansserif;font-size:1;font-weight:bold;"

/*
#define HUD_BAR_INTERNAL 0
#define HUD_BAR_EXTERNAL 1
#define HUD_BAR_CREW 2
*/

#define COMPONENT_GROUP_MIN 1
#define COMPONENT_GROUP_MAX 6

#define MOUNT_SMALL 0
#define MOUNT_MEDIUM 1
#define MOUNT_LARGE 2

#define MOUNT_INT 0
#define MOUNT_EXT 1
#define MOUNT_CREW 2

#define HUD_BAR_LEFT 0
#define HUD_BAR_TOP 1
#define HUD_BAR_RIGHT 2
#define HUD_BAR_BOTTOM 3

#define INSTALL_WELDED 1
#define INSTALL_CABLED 2
#define INSTALL_BOLTED 4
#define INSTALL_SCREWED 8
#define INSTALL_PIPED 16
#define INSTALL_CROWBAR 32
#define INSTALL_MAX 32

//put crowbar here for convenience, to cut down on stuff passed to topic()
var/global/list/tool_installs = list(\
	"welder" = INSTALL_WELDED,\
	"link" = INSTALL_CABLED,\
	"wrench" = INSTALL_BOLTED,\
	"pencil" = INSTALL_SCREWED,\
	"pipe" = INSTALL_PIPED,\
	"crowbar" = INSTALL_CROWBAR,\
	)

var/global/list/tool_installs_types = list(\
	/obj/item/weapon/weldingtool = INSTALL_WELDED,\
	/obj/item/stack/cable_coil = INSTALL_CABLED,\
	/obj/item/weapon/wrench = INSTALL_BOLTED,\
	/obj/item/weapon/screwdriver = INSTALL_SCREWED,\
	/obj/item/pipe = INSTALL_PIPED,\
	/obj/item/weapon/crowbar = INSTALL_CROWBAR,\
	)

var/global/list/tool_uninstalls = list(\
	"welder" = INSTALL_WELDED,\
	"scissors" = INSTALL_CABLED,\
	"wrench" = INSTALL_BOLTED,\
	"pencil" = INSTALL_SCREWED,\
	"welder2" = INSTALL_PIPED,\
	)

var/global/list/tool_uninstalls_types = list(\
	/obj/item/weapon/weldingtool = INSTALL_WELDED|INSTALL_PIPED,\
	/obj/item/weapon/wirecutters = INSTALL_CABLED,\
	/obj/item/weapon/wrench = INSTALL_BOLTED,\
	/obj/item/weapon/screwdriver = INSTALL_SCREWED,\
	/obj/item/weapon/crowbar = INSTALL_CROWBAR,\
	)

var/global/list/action_desc_tool = list(\
	"welding" = INSTALL_WELDED,\
	"wiring" = INSTALL_CABLED,\
	"bolting" = INSTALL_BOLTED,\
	"screwing" = INSTALL_SCREWED,\
	"piping" = INSTALL_PIPED,\
	)

var/global/list/tooltype_action_desc = list(\
	/obj/item/weapon/weldingtool = "welding",\
	/obj/item/weapon/wirecutters = "wirecutting",\
	/obj/item/weapon/wrench = "wrenching",\
	/obj/item/weapon/screwdriver = "screwing",\
	/obj/item/weapon/crowbar = "crowbarring",\
	/obj/item/stack/cable_coil = "wiring",\
	/obj/item/pipe = "piping",\
	)

/proc/vehicle_component_size_string(var/mount_size)
	var/size_string = "small"
	switch(mount_size)
		if(MOUNT_MEDIUM)
			size_string = "medium"
		if(MOUNT_LARGE)
			size_string = "large"
	return size_string

/proc/vehicle_component_type_string(var/mount_type)
	var/type_string = "internal"
	switch(mount_type)
		if(MOUNT_CREW)
			type_string = "crew compartment"
		if(MOUNT_EXT)
			type_string = "external"
	return type_string

/proc/get_tool_actionverb(var/install_type, var/install_direction = 0)
	. = "ACTIONVERB"		//hooray for error testing
	switch(install_type)
		if(INSTALL_WELDED)
			. = "weld"
		if(INSTALL_CABLED)
			. = "wire"
		if(INSTALL_BOLTED)
			. = "bolt"
		if(INSTALL_SCREWED)
			. = "screw"
		if(INSTALL_PIPED)
			. = "pipe"

	if(install_direction)
		. = "un" + .
