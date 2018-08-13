namespace :pairs do
  desc "generate_and_message"
  task :generate_and_message => :environment do
    client = Slack::Web::Client.new
    users = client.channels_info(channel: "#lunch-buddies").channel.members
    list = LunchRoulette::RegistrationList.new(users)
    list.generate_pairs
    list.pairs.each do |pair|
      puts "messaging #{pair} #{pairs.map { |u| client.users_info(user: u) }}"
      response = client.mpim_open(users: pair.join(","))
      channel_id = response.group.id
      client.chat_postMessage(channel: channel_id, text: "Hello there! You're up for lunch!", as_user: true)
    end
  end
end
