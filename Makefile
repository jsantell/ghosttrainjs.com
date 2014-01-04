PUBLIC=./public
APP=./app
BUILD=./build
JADE=./node_modules/jade/bin/jade.js
STYLUS=./node_modules/stylus/bin/stylus
LESS=./node_modules/less/bin/lessc
MARKDOWN=./node_modules/marked/bin/marked

all: api jade less stylus concat setuptests

api:
	node ./bin/buildapi
	cat api/GhostTrain.html > api/api.html
	cat api/Request.html >> api/api.html
	cat api/Response.html >> api/api.html
	rm api/GhostTrain.html api/Request.html api/Response.html

jade:
	node $(JADE) src/*.jade --out $(PUBLIC)

stylus:
	mkdir -p $(PUBLIC)/styles
	node $(STYLUS) < "./styles/app.styl" > $(PUBLIC)/styles/app.css

less:
	node $(LESS) ./vendor/styles/bootstrap/bootstrap.less > ./vendor/styles/bootstrap.css
	# node $(LESS) ./vendor/styles/font-awesome/font-awesome.less > ./vendor/styles/font-awesome.css

concat:
	cat ./scripts/ga.js > $(PUBLIC)/scripts/site.js
	cat ./vendor/scripts/prettify.js >> $(PUBLIC)/scripts/site.js
	cat ./vendor/scripts/jquery.js >> $(PUBLIC)/scripts/site.js
	cat ./vendor/scripts/scrollspy.js >> $(PUBLIC)/scripts/site.js
	cat ./scripts/app.js >> $(PUBLIC)/scripts/site.js
	
	cat ./vendor/styles/bootstrap.css > $(PUBLIC)/styles/site.css
	cat ./styles/prettify.css >> $(PUBLIC)/styles/site.css
	cat $(PUBLIC)/styles/app.css >> $(PUBLIC)/styles/site.css

setuptests:
	cd GhostTrain && npm install && make
	cd ..
	cp GhostTrain/build/test-bundle.js $(PUBLIC)/scripts/test-bundle.js
	cp GhostTrain/node_modules/mocha/mocha.js $(PUBLIC)/scripts/mocha.js
	cp GhostTrain/node_modules/expect.js/expect.js $(PUBLIC)/scripts/expect.js
	cp GhostTrain/node_modules/mocha/mocha.css $(PUBLIC)/styles/mocha.css

install:
	@npm install

.PHONY: api jade less stylus concat setuptests
