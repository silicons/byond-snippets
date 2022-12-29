/**
 * render map coordinates as /icon
 */
/proc/render_map_coords(x1, y1, x2, y2, z)
    return render_map(locate(x1, y1, z), locate(x2, y2, z))

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

    var/list/turf/turfs = block(bottomleft, topright)
    // coord bounds
    var/c_width = topright.x - bottomleft.x + 1
    var/c_height = topright.y - bottomleft.y + 1
    // pixel bounds
    var/p_width = world.icon_size * c_width
    var/p_height = world.icon_size * c_height

    // grab blank
    var/icon/slate = icon(BLANK_ICON_32X32, "")
    // scale to size
    slate.Scale(p_width, p_height)
    
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
