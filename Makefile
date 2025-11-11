OUT_ZIP=Devuan.zip
LNCR_EXE=Devuan.exe

DLR=curl
DLR_FLAGS=--silent --location
BASE_URL=https://jenkins.linuxcontainers.org/view/Images/job/image-devuan/architecture=amd64,release=excalibur,variant=default/lastSuccessfulBuild/artifact/rootfs.tar.xz
LNCR_ZIP_URL=https://github.com/yuk7/wsldl/releases/download/`curl https://api.github.com/repos/yuk7/wsldl/releases/latest -s | jq .name -r`/icons.zip
LNCR_ZIP_EXE=Devuan.exe

all: $(OUT_ZIP) ## build DevuanWSL

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

clean: ## clean cache
	@echo -e '\e[1;31mCleaning files...\e[m'
	-rm -r ziproot
	-rm Launcher.exe
	-rm icons.zip
	-rm rootfs.tar.xz

help: ## show this help
	@echo "Specify a command:"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[0;36m%-12s\033[m %s\n", $$1, $$2}'
	@echo ""
.PHONY: help
