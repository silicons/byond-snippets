/proc/icongen_batch_icons_and_emit(list/icon/icons, name)
	for(var/icon/I in icons)
		fcopy(I, "[OUTPUT_FOLDER_ICONGEN][name].png")
		#warn format
