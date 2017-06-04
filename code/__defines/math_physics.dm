// Math constants.
#define M_PI    3.14159265

#define R_IDEAL_GAS_EQUATION       8.31    // kPa*L/(K*mol).
#define ONE_ATMOSPHERE             101.325 // kPa.
#define IDEAL_GAS_ENTROPY_CONSTANT 1164    // (mol^3 * s^3) / (kg^3 * L).

// Radiation constants.
#define STEFAN_BOLTZMANN_CONSTANT    5.6704e-8 // W/(m^2*K^4).
#define COSMIC_RADIATION_TEMPERATURE 3.15      // K.
#define AVERAGE_SOLAR_RADIATION      200       // W/m^2. Kind of arbitrary. Really this should depend on the sun position much like solars.
#define RADIATOR_OPTIMUM_PRESSURE    3771      // kPa at 20 C. This should be higher as gases aren't great conductors until they are dense. Used the critical pressure for air.
#define GAS_CRITICAL_TEMPERATURE     132.65    // K. The critical point temperature for air.

#define RADIATOR_EXPOSED_SURFACE_AREA_RATIO 0.04 // (3 cm + 100 cm * sin(3deg))/(2*(3+100 cm)). Unitless ratio.
#define HUMAN_EXPOSED_SURFACE_AREA          5.2 //m^2, surface area of 1.7m (H) x 0.46m (D) cylinder

#define T0C  273.15 //    0.0 degrees celcius
#define T20C 293.15 //   20.0 degrees celcius
#define TCMB 2.7    // -270.3 degrees celcius

#define CLAMP01(x) max(0, min(1, x))
#define QUANTIZE(variable) (round(variable,0.0001))

#define INFINITY	1.#INF

#define TICKS_IN_DAY 		24*60*60*10
#define TICKS_IN_SECOND 	10


//Radio Communications defines
/*
#define SHORT_RANGE_RADIO 7
#define LONG_RANGE_RADIO 255
#define MAX_ANTENNA_STRENGTH 50
*/

//Signal loss over distance
//Apply these multipliers to the reception strength (broadcast transmission power + hearer's reception power) to get the distance for each tier

#define SIGNAL_4BAR_MOD 0
#define SIGNAL_3BAR_MOD 0.25
#define SIGNAL_2BAR_MOD 0.5
#define SIGNAL_1BAR_MOD 0.75
#define SIGNAL_TRACE 2
#define SIGNAL_ENCRYPT 3
#define SIGNAL_RUBBISH 4
