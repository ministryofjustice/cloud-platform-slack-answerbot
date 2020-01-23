require_relative '../config/environment'

module AnswerBot
  class App < SlackRubyBot::Bot
    
    scan(/([a-zA-Z0-9]*)/) do |client, data, input|
      return if (!SlackRubyBot::Config.allow_message_loops?) && (client.self && client.self.id == data.user)
      input = data.text
      keyword_list = {
        ["resource limits", "namespace request limits", "usage report"] => 
          "I found this on user guide https://user-guide.cloud-platform.service.justice.gov.uk/concepts.html#namespace-container-resource-limits",
        ["template deploy", "DNS changes", "AWS access"] => 
          "I found this on user guide https://user-guide.cloud-platform.service.justice.gov.uk/concepts.html#migrating-to-the-cloud-platform-from-template-deploy",
        ["kubectl installation"] => 
          "I found this on user guide https://user-guide.cloud-platform.service.justice.gov.uk/tasks.html#installation",
        ["authenticate"] => 
          "I found this on user guide https://user-guide.cloud-platform.service.justice.gov.uk/tasks.html#authentication",
        ["migrate RDS", "RDS instance"] => 
          "I found this on user guide https://user-guide.cloud-platform.service.justice.gov.uk/tasks.html#migrating-an-rds-instance",
        ["grafana dashboard", "prometheus metrics", "custom alerts"] => 
          "I found this on user guide https://user-guide.cloud-platform.service.justice.gov.uk/tasks.html#monitoring-applications",
        ["gpg", "git-crypt"] => 
          "I found this on user guide https://user-guide.cloud-platform.service.justice.gov.uk/tasks.html#git-crypt",
        ["pingdom check"] => 
          "I found this on user guide https://user-guide.cloud-platform.service.justice.gov.uk/documentation/monitoring-an-app/how-to-create-pingdom-checks.html#creating-pingdom-checks", 
        ["IP Whitelisting", "NAT gateway"] => 
          "I found this on user guide https://user-guide.cloud-platform.service.justice.gov.uk/documentation/other-topics/ip-whitelisting.html#ip-whitelisting",  
        ["default backend", "custom error page", "http errors"] => 
          "I found this on user guide https://user-guide.cloud-platform.service.justice.gov.uk/documentation/other-topics/custom-default-backend.html#custom-default-backend",  
        ["CreateContainerConfigError"] =>
          "Do you see any information on `kubectl -n [your namespace] get events` or `kubectl -n <namespace> describe <pod_name>`"
      }

      keyword_list.each do |list, text|
        list.each do |keyword|
          if input.include?(keyword) && input.match(/docs|guide|documentation|user guide/) && !input.include?("PR")
            puts "Keyword match #{keyword}"
            client.say(channel: data.channel, text: "#{text} Does this help?")
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
