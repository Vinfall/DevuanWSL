OUT_ZIP=Devuan.zip
LNCR_EXE=Devuan.exe

DLR=curl
DLR_FLAGS=--silent --location
BASE_URL=https://jenkins.linuxcontainers.org/view/Images/job/image-devuan/architecture=amd64,release=daedalus,variant=default/lastSuccessfulBuild/artifact/rootfs.tar.xz
LNCR_ZIP_URL!=curl --silent https://api.github.com/repos/yuk7/wsldl/releases | jq --raw-output ".[0].assets[].browser_download_url" | grep --extended-regexp "icons.zip"
LNCR_ZIP_EXE=Devuan.exe

all: $(OUT_ZIP)

zip: $(OUT_ZIP)
$(OUT_ZIP): ziproot
	@echo -e '\e[1;31mBuilding $(OUT_ZIP)\e[m'
	cd ziproot; bsdtar -a -cf ../$(OUT_ZIP) *

ziproot: Launcher.exe rootfs.tar.xz
	@echo -e '\e[1;31mBuilding ziproot...\e[m'
	mkdir ziproot
	cp Launcher.exe ziproot/${LNCR_EXE}
	cp rootfs.tar.xz ziproot/

exe: Launcher.exe
Launcher.exe: icons.zip
	@echo -e '\e[1;31mExtracting Launcher.exe...\e[m'
	unzip icons.zip $(LNCR_ZIP_EXE)
	mv $(LNCR_ZIP_EXE) Launcher.exe
	
icons.zip:
	@echo -e '\e[1;31mDownloading icons.zip...\e[m'
	$(DLR) $(DLR_FLAGS) $(LNCR_ZIP_URL) -o icons.zip

rootfs.tar.xz:
	@echo -e '\e[1;31mDownloading base.tar.gz...\e[m'
	$(DLR) $(DLR_FLAGS) $(BASE_URL) -o rootfs.tar.xz

clean:
	@echo -e '\e[1;31mCleaning files...\e[m'
	-rm -r ziproot
	-rm Launcher.exe
	-rm icons.zip
	-rm rootfs.tar.xz
