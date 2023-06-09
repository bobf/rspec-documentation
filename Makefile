project=rspec-documentation

.PHONY: test
test:
	bundle exec rspec
	bundle exec rubocop
	bundle exec strong_versions
	exe/rspec-documentation

.PHONY: publish
publish:
	@RSPEC_DOCUMENTATION_URL_ROOT='/$(project)' exe/rspec-documentation
	@rsync --delete -r rspec-documentation/bundle/ docs01.bob.frl:/mnt/docs/$(project)/
	@echo 'Published.'
