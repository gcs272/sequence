TEST_FILES=`find test -type f -name '*.coffee'`

watch:
	watchify -v -t coffeeify -t hamlify app/app.coffee -o public.app.js

deploy:
	make test && \
	uglifyjs public/app.js -c -o public/app.min.js && \
	mv public/app.min.js public/app.js && \
	rsync -r public/* sequence.gcs.io:/home/graham/www/

test:
	@NODE_PATH=app/ mocha --compilers coffee:coffee-script -R spec $(TEST_FILES)

.PHONY: test watch
