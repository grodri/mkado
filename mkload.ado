program mkload
*! Compile and load mata functions / v 1.0 6mar2019 grodri@princeton.edu
	version 11
	syntax anything [, all]
	if "`all'" == "all" {
		confirm file "`anything'.mkm"
		mata mkall("`syntax'")
	}
	else {
		confirm file "`fname'.mata"
		tempfile dofile
		mata mkload("`fname'", "`dofile'")
		do `dofile'
	}
end

mata:
	void mkload(string scalar fname, string scalar outname) {
		fout = fopen(outname, "w")
		fput(fout, "capture mata mata drop " + fname + "()")
		fput(fout, "mata:")
		code = cat(fname + ".mata")
		for(i=1; i <= length(code); i++) {
			fput(fout, code[i])
		}
		fput(fout, "end")					
		fclose(fout)
	}
	void mkall(string scalar mname) {
		map = cat(mname + ".mkm")
		fcts = map[select(1::length(map), ustrregexm(map, ":[A-Za-z0-9]+"))]
		for(i=1; i <= length(fcts); i++) {
			fname = usubstr(fcts[i], 2, .)
			stata("mkload " + fname)
		}
	}
end
	