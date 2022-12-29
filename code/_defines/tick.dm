/// amount of tick to yield at
#define TICK_YIELD_THRESHOLD 75

/// yield if tick is over limit
#define YIELD_FOR_LAG if(world.tick_usage > TICK_YIELD_THRESHOLD) sleep(world.tick_lag * 2)
