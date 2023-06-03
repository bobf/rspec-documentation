.PHONY: test
test:
	bundle exec rspec
	bundle exec rubocop
	bundle exec strong_versions
	exe/rspec-documentation
