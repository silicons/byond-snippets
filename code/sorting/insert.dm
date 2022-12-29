/**
 * insertion sort
 * great for small lists (< 20), terrible otherwise
 *
 * this is not inplace, e.g. will return a new list.
 * this is not stable, e.g. does not preserve relative order
 * this will preserve associations
 *
 * @params
 * * L - list
 * * cmp - comparator proc; called with (A, B), return -1 for before, 0 for neutral, 1 for after
 * * start - start index
 * * end - end index
 * * assoc - associative?
 *
 * @return sorted list
 */
/proc/insertion_sort(list/L, cmp = /proc/cmp_auto_asc, assoc)
	var/list/sorted = list()
	var/i
	var/inserted
	while(length(L))
		inserted = FALSE
		var/len = length(L)
		var/elem = L[len]
		if(assoc)
			for(i in 1 to length(sorted))
				if(call(cmp)(L[elem], sorted[sorted[i]]) <= 0)
					sorted.Insert(i, elem)
					sorted[elem] = L[elem]
					inserted = TRUE
					break
		else
			for(i in 1 to length(sorted))
				if(call(cmp)(elem, sorted[i]) <= 0)
					sorted.Insert(i, elem)
					sorted[elem] = L[elem]
					inserted = TRUE
					break
		if(!inserted)
			sorted[elem] = L[elem]
		--L.len
	return sorted
