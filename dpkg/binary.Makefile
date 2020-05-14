BUILD_DIR?=build
PACKAGE_DIR?=package
SOURCE_PACKAGE?=???_source.deb
DEBUILD_OPTS?=

DEBIAN_FOLDER:=debian
CHANGES_FILE:=*.changes

default: all

$(PACKAGE_DIR):
	mkdir -p $(PACKAGE_DIR)

$(BUILD_DIR)/$(DEBIAN_FOLDER):
	dpkg-source -x $(SOURCE_PACKAGE) $(BUILD_DIR)

$(BUILD_DIR)/$(CHANGES_FILE):: $(BUILD_DIR)/$(DEBIAN_FOLDER)
	cd $(BUILD_DIR) && debuild -jauto $(DEBUILD_OPTS)

build: $(BUILD_DIR)/$(CHANGES_FILE)
	mkdir -p $(PACKAGE_DIR)

	cd $(BUILD_DIR) && cp --reflink=auto $$(sed -n '/Files:/,$$p' $(DSC_FILE) | grep -E "\.dsc$$|\.tar.xz$$|\.tar.gz$$" | sed 's/.* //' | xargs) $(CURDIR)/$(PACKAGE_DIR)/
	cp --reflink=auto $(BUILD_DIR)/$(DSC_FILE) $(PACKAGE_DIR)/

	cd $(BUILD_DIR) && cp --reflink=auto $$(sed -n '/Files:/,$$p' $(CHANGES_FILE) | grep -E "\.tar.gz$$|\.deb$$|\.ddeb$$|\.buildinfo$$" | sed 's/.* //' | xargs) $(CURDIR)/$(PACKAGE_DIR)/
	cp --reflink=auto $(BUILD_DIR)/$(CHANGES_FILE) $(PACKAGE_DIR)/

clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(PACKAGE_DIR)

list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

all: build
.PHONY: build clean list all
