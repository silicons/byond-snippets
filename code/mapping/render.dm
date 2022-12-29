//! known limitations for file:
//? - does not support vis_contents yet
//? - only handles non-isomorphic, top-down maps
//? - any limitations in icons/render.dm

/**
 * render map coordinates as /icon
 */
/proc/render_map_coords(x1, y1, x2, y2, z)
	return render_map(locate(x1, y1, z), locate(x2, y2, z))

/**
 * render map level as /icon
 */
/proc/render_map_level(z)
	return render_map(locate(1, 1, z), locate(world.maxx, world.maxy, z))

/**
 * render map as /icon
 *
 * @params
 * * bottomleft - bottom left turf
 * * topright - top right turf
 */
/proc/render_map(turf/bottomleft, turf/topright)
	ASSERT(bottomleft)
	ASSERT(topright)
	ASSERT(bottomleft.z == topright.z)
	ASSERT(bottomleft.x <= topright.x)
	ASSERT(bottomleft.y <= topright.y)

	// coord bounds
	var/c_width = topright.x - bottomleft.x + 1
	var/c_height = topright.y - bottomleft.y + 1
	var/bl_x = bottomleft.x
	var/bl_y = bottomleft.y
	// pixel bounds
	var/p_width = world.icon_size * c_width
	var/p_height = world.icon_size * c_height
	// z
	var/z = bottomleft.z

	// grab blank
	var/icon/slate = icon(BLANK_ICON_32X32, "")
	// scale to size
	slate.Scale(p_width, p_height)

	// we can avoid some unnecessary float math by just for'ing instead of for turf in
	var/processed = 0
	WORLD_VERBOSE("rendering map z-index [z]")
	for(var/x in bottomleft.x to topright.x)
		for(var/y in bottomleft.y to topright.y)
			var/rel_x = x - bl_x
			var/rel_y = y - bl_y
			var/turf/T = locate(x, y, z)
			// max 20 atoms per tile
			var/list/sorted = insertion_sort(T.contents.Copy(1, 20))
			for(var/atom/A as anything in sorted)
				if(isarea(A))
					// don't care, did NOT ask
					continue
				if(A.plane in __map_render_ignore_planes)
					// ignore this plane
					continue
				var/off_x
				var/off_y
				if(ismovable(A))
					var/atom/movable/AM = A
					off_x = AM.step_x + AM.pixel_x
					off_y = AM.step_y + AM.pixel_y
				else
					off_x = A.pixel_x
					off_y = A.pixel_y
				slate.Blend(render_icon(A, no_anim = TRUE), x = rel_x * world.icon_size + 1 + off_x, y = rel_y * world.icon_size + 1 + off_y)
			++processed
			YIELD_FOR_LAG
			if(!(processed % 1000))
				WORLD_VERBOSE("map render: [processed]...")
	return slate

/**
 * downloads a rendered part of the map
 *
 * @params
 * * bottomleft - bottom left turf
 * * topright - top right turf
 */
/client/proc/download_rendered_map(turf/bottomleft, turf/topright)
	var/icon/rendered = render_map(bottomleft, topright)
	if(!rendered)
		return
	src << ftp(rendered, "map-render-[rand(0,999999)].png")

/**
 * downloads a rendered level
 *
 * @params
 * * z - level index
 */
/client/proc/download_rendered_map_level(z)
	var/icon/rendered = render_map_level(z)
	if(!rendered)
		return
	src << ftp(rendered, "map-render-[rand(0,999999)].png")
