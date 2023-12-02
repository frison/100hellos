# So janky.  Free Pascal ships its binaries as a tar of tar.gz files along
# with a setup script that isn't amenable to scripted execution.  So, we
# do a little workaround and manually unpack the executable and the minimum
# units we need to run our program.
#
# If you want to do anything more advanced, this'll need to be updated
# to install all the shipped units.
install:
	wget -O fpc-3.2.2.x86_64-linux.tar https://sourceforge.net/projects/freepascal/files/Linux/3.2.2/fpc-3.2.2.x86_64-linux.tar/download
	tar -xf fpc-3.2.2.x86_64-linux.tar
	rm fpc-3.2.2.x86_64-linux.tar
	cd fpc-3.2.2.x86_64-linux && tar -xf binary.x86_64-linux.tar
	[[ ! -d $(HOME)/.local/ ]] && mkdir $(HOME)/.local
	tar -C $(HOME)/.local -xf fpc-3.2.2.x86_64-linux/base.x86_64-linux.tar.gz
	tar -C $(HOME)/.local -xf fpc-3.2.2.x86_64-linux/utils.x86_64-linux.tar.gz
	tar -C $(HOME)/.local -xf fpc-3.2.2.x86_64-linux/units-rtl-console.x86_64-linux.tar.gz
	tar -C $(HOME)/.local -xf fpc-3.2.2.x86_64-linux/units-rtl-extra.x86_64-linux.tar.gz
	tar -C $(HOME)/.local -xf fpc-3.2.2.x86_64-linux/units-rtl-generics.x86_64-linux.tar.gz
	tar -C $(HOME)/.local -xf fpc-3.2.2.x86_64-linux/units-rtl-objpas.x86_64-linux.tar.gz
	tar -C $(HOME)/.local -xf fpc-3.2.2.x86_64-linux/units-rtl-unicode.x86_64-linux.tar.gz
	rm -rf fpc-3.2.2.x86_64-linux
	ln -s $(HOME)/.local/lib/fpc/3.2.2/ppcx64 $(HOME)/.local/bin/ppcx64
