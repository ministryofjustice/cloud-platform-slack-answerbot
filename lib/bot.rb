require_relative '../config/environment'

module AnswerBot
  class App < SlackRubyBot::Bot
    
    scan(/([a-zA-Z0-9]*)/) do |client, data, input|
      return if (!SlackRubyBot::Config.allow_message_loops?) && (client.self && client.self.id == data.user)
      input = data.text
      keyword_list = {
        ["user guide"] => 
          "https://user-guide.cloud-platform.service.justice.gov.uk",
        ["resource limits", "namespace request limits", "usage report"] => 
          "https://user-guide.cloud-platform.service.justice.gov.uk/concepts.html#namespace-container-resource-limits",
        ["template deploy", "DNS changes", "AWS access"] => 
          "https://user-guide.cloud-platform.service.justice.gov.uk/concepts.html#migrating-to-the-cloud-platform-from-template-deploy",
        ["kubectl installation"] => 
          "https://user-guide.cloud-platform.service.justice.gov.uk/tasks.html#installation",
        ["authenticate"] => 
          "https://user-guide.cloud-platform.service.justice.gov.uk/tasks.html#authentication",
        ["migrate RDS", "RDS instance"] => 
          "https://user-guide.cloud-platform.service.justice.gov.uk/tasks.html#migrating-an-rds-instance",
        ["grafana dashboard", "prometheus metrics", "custom alerts"] => 
          "https://user-guide.cloud-platform.service.justice.gov.uk/tasks.html#monitoring-applications"
      }

      keyword_list.each do |list, href|
        list.each do |keyword|
          if input.include?(keyword)
            puts "Keyword match #{keyword}"
            client.say(channel: data.channel, text: "User guide: #{href}")
          end
        end
      end

    end

  end

  class Default < SlackRubyBot::Commands::Base
    match /^(?<bot>\w*)$/

    def self.call(client, data, _match)
      client.say(channel: data.channel, text: "hello")
    end
  end
end
