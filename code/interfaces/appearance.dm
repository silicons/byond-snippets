/**
 * an interface for BYOND internal appearances
 * 
 * ! warning: this can change from version to version. !
 * 
 * make sure it is kept up to date for relevant usages by someone
 * with good knowledge of the BYOND engine.
 * 
 * this interface can be used for:
 * * /atoms
 * * appearance var for atoms
 * * overlays in overlays list (internally just an appearance)
 */
/appearance
	var/alpha
	var/appearance_flags
	var/blend_mode
	var/color
	var/desc
	var/dir
	var/gender
	var/icon
	var/icon_state
	var/invisibility
	var/infra_luminosity
	var/list/filters
	var/layer
	var/luminosity
	var/maptext
	var/maptext_width
	var/maptext_height
	var/maptext_x
	var/maptext_y
	var/mouse_over_pointer
	var/mouse_drag_pointer
	var/mouse_drop_pointer
	var/mouse_drop_zone
	var/mouse_opacity
	var/name
	var/opacity
	var/list/overlays
	var/override
	var/pixel_x
	var/pixel_y
	var/pixel_w
	var/pixel_z
	var/plane
	var/render_source
	var/render_target
	var/suffix
	var/text
	var/transform
	var/list/underlays
