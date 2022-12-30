//! known limitations for file:
//? - does not handle vis_contents
//? - will not respect overlay/underlay planes

/**
 * renders an appearancelike object into an /icon with all sides
 *
 * @params
 * * A - an appearancelike; see the /appearance interface
 */
/proc/render_full_icon(appearance/A, no_anim)
	var/icon/slate = icon()
	var/icon/inserting
	inserting = render_icon(A, NORTH, no_anim)
	slate.Insert(inserting, dir = NORTH)
	inserting = render_icon(A, SOUTH, no_anim)
	slate.Insert(inserting, dir = SOUTH)
	inserting = render_icon(A, EAST, no_anim)
	slate.Insert(inserting, dir = EAST)
	inserting = render_icon(A, WEST, no_anim)
	slate.Insert(inserting, dir = WEST)
	return slate

/**
 * renders an appearancelike object into an /icon
 *
 * @params
 * * A - an appearancelike; see the /appearance interface.
 * * dir - forcefully render this dir, else defaults to A's dir
 * * no_anim - do NOT render animated states
 */
/proc/render_icon(appearance/A, dir, no_anim)
	return render_icon_internal(A, no_anim, dir? dir : A.dir, A.icon)

/**
 * @params
 * * A - an appearancelike; see the /appearance interface.
 * * no_anim - do NOT render animated states
 * * d_dir - default dir
 * * d_icon - default icon
 */
/proc/render_icon_internal(appearance/A, no_anim, d_dir, d_icon)
	// sanity
	if(length(A.underlays) > 50 || length(A.overlays) > 50)
		WORLD_VERBOSE("Skipping [isatom(A)? A : ref(A)] - >50 underlays or overlays")
		return

	// start with blank slate
	var/icon/slate = icon(BLANK_ICON_32X32, "")

	// get relevant icon and dir

	// underlays / overlays will use simple insertion sort
	var/list/lays

	// handle underlays
	lays = list()
	for(var/appearance/app as anything in A.underlays)
		var/inserted = FALSE
		for(var/i in 1 to length(lays))
			var/appearance/app2 = lays[i]
			if(app2.layer < app.layer)
				continue
			lays.Insert(i, app)
			inserted = TRUE
			break
		if(!inserted)
			lays += app

	// render underlays

	// render self

	// handle overlays
	lays = list()

	for(var/appearance/app as anything in A.overlays)
		var/inserted = FALSE
		for(var/i in 1 to length(lays))
			var/appearance/app2 = lays[i]
			if(app2.layer < app.layer)
				continue
			lays.Insert(i, app)
			inserted = TRUE
			break
		if(!inserted)
			lays += app

	// render overlays

	#warn impl

/**
 * downloads a rendered icon
 *
 * @params
 * * A - an appearancelike; see the /appearance interface
 * * dir - force a direction, otherwise gets all
 * * no_anim - do NOT render animated states
 */
/client/proc/download_rendered_icon(appearance/A, dir, no_anim)
	var/icon/rendered
	if(!dir)
		rendered = render_full_icon(A, no_anim)
	else
		rendered = render_icon(A, dir, no_anim)
	src << ftp(rendered, "[A.name || "generated"]-[rand(0,999999)].png")
