IMAGE := cloud-platform-slack-answerbot
VERSION := 1.5
ORG := ministryofjustice
TAGGED := $(ORG)/$(IMAGE):$(VERSION)

build: .built-docker-image

clean:
	docker rmi $(IMAGE) --force
	docker rmi $(TAGGED) --force
	rm .built-docker-image
	
.built-docker-image: Dockerfile Gemfile Rakefile config.ru config/environment.rb bin/run.rb $(wildcard lib/*.rb)
	docker build -t $(IMAGE) .
	docker tag $(IMAGE) $(TAGGED)
	touch .built-docker-image

docker-push: .built-docker-image
	docker push $(TAGGED)

# Run a local copy of the Slack Answer bot.
# Set the SLACK_API_TOKEN as environment variable. 
# The SLACK_API_TOKEN is the OAuth token for the bot user staring with xoxb provided in OAuth permissions of slack settings

server: .built-docker-image
	docker run \
		-p 9292:9292 \
		-e SLACK_API_TOKEN=$${SLACK_API_TOKEN} \
		-it $(TAGGED)
