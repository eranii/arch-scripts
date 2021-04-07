SCRIPTFILES=$(shell find scripts -type f)
DESTINATION_PATH=$(HOME)/.local/bin

install:
	mkdir -p ${DESTINATION_PATH}
	cp ${SCRIPTFILES} ${DESTINATION_PATH}
	@echo "Installation done. Add ${DESTINATION_PATH} to your PATH environment variable"
