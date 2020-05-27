require_relative '../config/environment'

module AnswerBot
  class App < SlackRubyBot::Bot

    match /\b(how)\b.*\b(add)\b.*\b(git-crypt)\b.*collab.*$/i do |client, data, _match|
      client.say(text: "I found this on user guide https://user-guide.cloud-platform.service.justice.gov.uk/documentation/other-topics/git-crypt-setup.html#git-crypt. Does this help?",
      channel: data.channel,
      thread_ts: data.thread_ts || data.ts)
    end
  

    match /\b(how)\b.*(\b(add)\b.*\b(pingdom)\b|\b(pingdom)\b.*\b(add)\b).*$/i do |client, data, _match|
      client.say(text: "I found this on user guide https://user-guide.cloud-platform.service.justice.gov.uk/documentation/monitoring-an-app/how-to-create-pingdom-checks.html#overview. Does this help?",
      channel: data.channel,
      thread_ts: data.thread_ts || data.ts)
    end
    
    match /\b(how)\b.*\b(access|events)\b.*\b(kibana)\b.*$/i do |client, data, _match|
      client.say(text: "I found this on user guide https://user-guide.cloud-platform.service.justice.gov.uk/documentation/logging-an-app/access-logs.html#accessing-application-log-data. Does this help?",
      channel: data.channel,
      thread_ts: data.thread_ts || data.ts)
    end
    
    match /^(localhost:8080).*(connection refused).*$/i do |client, data, _match|
      client.say(text: "Have you gone through the process mentioned here: https://user-guide.cloud-platform.service.justice.gov.uk/documentation/getting-started/kubectl-config.html#how-to-use-kubectl-to-connect-to-the-cluster",
      channel: data.channel,
      thread_ts: data.thread_ts || data.ts)
    end
   
    match /((add).*\b(github)\b|\b(github)\b.*\b(permissions)\b).*$/i do |client, data, _match|
      client.say(text: "Do you want to add any member of your team to Organisation GitHub? 
        If so, please talk to #digitalservicedesk. If not, please wait, a member of Cloud Platform team will respond",
      channel: data.channel,
      thread_ts: data.thread_ts || data.ts)
    end

  end

  class Default < SlackRubyBot::Commands::Base
    match /^(?<bot>\w*)$/

    def self.call(client, data, _match)
      client.say(channel: data.channel, text: "hello")
    end
  end
end
