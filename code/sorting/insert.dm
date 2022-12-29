/**
 * insertion sort
 * great for small lists (< 20), terrible otherwise
 * 
 * @params
 * * L - list
 * * cmp - comparator proc; called with (A, B), return -1 for before, 0 for neutral, 1 for after
 * * start - start index
 * * end - end index
 * * assoc - associative?
 */
/proc/insertion_sort(list/L, cmp = /proc/cmp_auto_asc, start, end, assoc)
    #warn impl
