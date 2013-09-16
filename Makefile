TEST_FILES=`find test -type f -name '*.coffee'`

test:
	@NODE_PATH=app/ mocha --compilers coffee:coffee-script -R spec $(TEST_FILES)

.PHONY: test
