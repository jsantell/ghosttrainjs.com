PUBLIC=./public
APP=./app
BUILD=./build
JADE=./node_modules/jade/bin/jade.js
STYLUS=./node_modules/stylus/bin/stylus
LESS=./node_modules/less/bin/lessc
MARKDOWN=./node_modules/marked/bin/marked

all: api jade less stylus concat

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
	cat ./vendor/scripts/prettify.js > $(PUBLIC)/scripts/site.js
	cat ./vendor/scripts/jquery.js >> $(PUBLIC)/scripts/site.js
	cat ./vendor/scripts/scrollspy.js >> $(PUBLIC)/scripts/site.js
	cat ./scripts/app.js >> $(PUBLIC)/scripts/site.js
	
	cat ./vendor/styles/bootstrap.css > $(PUBLIC)/styles/site.css
	cat ./styles/prettify.css >> $(PUBLIC)/styles/site.css
	cat $(PUBLIC)/styles/app.css >> $(PUBLIC)/styles/site.css

min:
	node $(UGLIFY) $(PUBLIC)/scripts/landing.js -o $(PUBLIC)/scripts/landing.min.js
	node $(UGLIFY) $(PUBLIC)/scripts/site.js -o $(PUBLIC)/scripts/site.min.js
	node $(CLEANCSS) $(PUBLIC)/styles/site.css -o $(PUBLIC)/styles/site.min.css
	node $(CLEANCSS) $(PUBLIC)/styles/site-landing.css -o $(PUBLIC)/styles/site-landing.min.css
	# Add GA script to production
	cat ./vendor/scripts/ga.js > ./tmp && cat $(PUBLIC)/scripts/site.min.js >> ./tmp
	mv ./tmp $(PUBLIC)/scripts/site.min.js

install:
	@npm install

.PHONY: api jade less stylus concat
