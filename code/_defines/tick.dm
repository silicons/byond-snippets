/// amount of tick to yield at
#define TICK_YIELD_THRESHOLD 75
/// yield inner
#define TICK_YIELD_DEFAULT sleep(world.tick_lag * 2)

/// yield if tick is over limit
#define YIELD_FOR_LAG if(world.tick_usage > TICK_YIELD_THRESHOLD) TICK_YIELD_DEFAULT
/// yield if condition is not true
#define YIELD_UNTIL_CONDITION(COND) while(!(COND)) TICK_YIELD_DEFAULT
