/**
 * converts blend_mode from /atom to icon.Blend() mode
 */
/proc/atom_blend_to_icon_blend(mode)
	switch(mode)
		if(BLEND_DEFAULT, BLEND_OVERLAY, BLEND_INSET_OVERLAY)
			return ICON_OVERLAY
		if(BLEND_ADD)
			return ICON_ADD
		if(BLEND_SUBTRACT)
			return ICON_SUBTRACT
		if(BLEND_MULTIPLY)
			return ICON_MULTIPLY
