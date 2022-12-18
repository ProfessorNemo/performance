RUN_ARGS := $(wordlist 2, $(words $(MAKECMDGOALS)), $(MAKECMDGOALS))

drop:
	rails db:drop

initially:
	rails db:create
	rails db:migrate
	rails db:seed

rubocop:
	rubocop -A

rspec:
	bundle exec rspec spec/controllers/events_controller_spec.rb
	bundle exec rspec spec/models/events_spec.rb
	bundle exec rspec spec/acceptance/events_spec.rb
	bundle exec rspec spec/requests/client_spec.rb
	bundle exec rspec spec/requests/api_json_spec.rb

web:
	ruby bin/rails server -p 3000

run-console:
	bundle exec rails console

c: run-console

.PHONY:	db
