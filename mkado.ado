program mkado
*! Make ado from manifest and files - v 1.0 6mar2019 grodri@princeton.edu
	version 11
	args progname
	confirm file "`progname'.mkm"
	mata mkado("`progname'")
	capture program drop `progname'
end

mata:
	void mkado(string scalar pname) {
		map = cat(pname + ".mkm")
		outfile = pname + ".ado"
		if(fileexists(outfile)) unlink(outfile)
		fout = fopen(outfile, "w")
		for(i=1; i <= length(map); i++) {
			ch = usubstr(map[i], 1, 1)
			if(ch == "." | ch == ":") {
				codefile = usubstr(map[i], 2, .)
				codext = ch == "." ? ".ado" : ".mata"
				printf("%s\n",   codefile + codext)
				appendFile(fout, codefile + codext)
			}
			else {
				fput(fout, map[i])
			}
		}
		fclose(fout)
	}
	void appendFile(real scalar fout, string scalar filename) {
		code = cat(filename)
		for(i = 1; i <= length(code); i++) {
			fput(fout, code[i])
		}
	}
end
exit	
