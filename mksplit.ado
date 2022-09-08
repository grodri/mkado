program mksplit
*! Split ado into manifest and files / v1.0 6mar2019 grodri@princeton.edu
	version 11
	args cmdname
	confirm file "`cmdname'.ado"
	mata: mksplit("`cmdname'")
end

mata:
	void mksplit(string scalar cmdname) {
		string vector lines
		string scalar trim
		real scalar i
		lines = cat(cmdname + ".ado")
		//
		// get main command
		i = 1
		while(i <= length(lines)) {
			printf("%s\n", lines[i])
			trim = ustrtrim(lines[i])
			if(trim == "end") break
			i++
		}
	}
end

	