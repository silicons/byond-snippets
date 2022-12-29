/**
 * renders an appearancelike object into an /icon with all sides
 * 
 * @params
 * * A - an appearancelike; see the /appearance interface
 */
/proc/render_full_icon(appearance/A, no_anim)

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
    /// start with blank slate
    var/icon/slate = icon(BLANK_ICON_32X32, "")

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
    src << ftp(rendered, "[A.name || generated]-[rand(0,999999)].png")
