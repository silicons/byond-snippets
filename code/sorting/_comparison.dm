//! OOP-based comparator

/**
 * compares us to another
 *
 * this should:
 * return 1 for "i come before other"
 * return 0 for same
 * return -1 for "i come after other"
 */
/datum/proc/auto_compare(datum/other)
	return 0

/**
 * ascending - auto
 */
/proc/cmp_auto_asc(datum/A, datum/B)
	if(istext(A))
		return sorttext(B, A)
	if(isnum(A))
		return A - B
	return A.auto_compare(B)

/**
 * descending - auto
 */
/proc/cmp_auto_dsc(datum/A, datum/B)
	return cmp_auto_asc(B, A)

//! standard comparators

//? numbers

/proc/cmp_num_asc(A, B)
	return A - B

/proc/cmp_num_dsc(A, B)
	return B - A

//? text

/proc/cmp_str_asc(A, B)
	return sorttext(B, A)

/proc/cmp_str_dsc(A, B)
	return sorttext(A, B)

/proc/cmp_strlen_asc(A, B)
	return length(A) - length(B)

/proc/cmp_strlen_dsc(A, B)
	return length(B) - length(A)

/proc/cmp_strlen_char_asc(A, B)
	return length_char(A) - length_char(B)

/proc/cmp_strlen_char_dsc(A, B)
	return length_char(B) - length_char(A)

//? atoms

/proc/cmp_atom_layering_asc(atom/A, atom/B)
	if(A.plane != B.plane)
		return A.plane - B.plane
	return A.layer - B.layer

/proc/cmp_atom_layering_dsc(atom/A, atom/B)
	if(A.plane != B.plane)
		return B.plane - A.plane
	return B.layer - A.layer
