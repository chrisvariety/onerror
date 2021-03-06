TESTS = test/*.test.js
REPORTER = spec
TIMEOUT = 3000
MOCHA_OPTS =
REGISTRY = --registry=http://r.cnpmjs.org

install:
	@npm install $(REGISTRY) \
		--disturl=http://dist.cnpmjs.org

jshint: install
	@-./node_modules/.bin/jshint ./

test: install
	@./node_modules/.bin/mocha \
	  --harmony \
	  --bail \
		--reporter $(REPORTER) \
		--timeout $(TIMEOUT) \
		--require should \
		$(MOCHA_OPTS) \
		$(TESTS)

test-cov: install
	@node --harmony \
		node_modules/.bin/istanbul cover --preserve-comments \
		./node_modules/.bin/_mocha \
		-- -u exports \
		--reporter $(REPORTER) \
		--timeout $(TIMEOUT) \
		--require should \
		$(MOCHA_OPTS) \
		$(TESTS)
	@./node_modules/.bin/cov coverage

autod: install
	@./node_modules/.bin/autod $(REGISTRY) -w
	@$(MAKE) install

.PHONY: test test-all
