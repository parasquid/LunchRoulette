questions = [
  "Given the choice of anyone in the world, whom would you want as a dinner guest?",
  "Would you like to be famous? In what way?",
  "Before making a phone call, do you ever rehearse what you’re going to say? Why?",
  "What would constitute a perfect day for you?",
  "When did you last sing to yourself? To someone else?",
  "If you were able to live to the age of 90 and retain either the mind or body of a 30-year old for the last 60 years of your life, which would you choose?",
  "Do you have a secret hunch about how you will die?",
  "Name three things you and your buddy appear to have in common.",
  "For what in your life do you feel most grateful?",
  "If you could change anything about the way you were raised, what would it be?",
  "Take four minutes and tell you buddy your life story in as much detail as possible.",
  "If you could wake up tomorrow having gained one quality or ability, what would it be?",
  "If a crystal ball could tell you the truth about yourself, your life, the future or anything else, what would you want to know?",
  "Is there something that you’ve dreamed of doing for a long time? Why haven’t you done it?",
  "What is the greatest accomplishment of your life?",
  "What do you value most in a friendship?",
  "What is your most treasured memory?",
  "What is your most terrible memory?",
  "If you knew that in one year you would die suddenly, would you change anything about the way you are living now? Why?",
  "What does friendship mean to you?",
  "What roles do love and affection play in your life?",
  "Alternate sharing something you consider a positive characteristic of your buddy. Share a total of five items.",
  "How close and warm is your family? Do you feel your childhood was happier than most other people’s?",
  "How do you feel about your relationship with your mother?",
  "Make three true “we” statements each. For instance, “we are both in this room feeling…”",
  "Complete this sentence: “I wish I had someone with whom I could share…”",
  "If you were going to become a close friend with your buddy, please share what would be important for him or her to know.",
  "Tell your buddy what you like about them: Be honest this time, saying things that you might not say to someone you’ve just met.",
  "Share with your buddy an embarrassing moment in your life.",
  "When did you last cry in front of another person? By yourself?",
  "Tell your buddy something that you like about them already.",
  "What, if anything, is too serious to be joked about?",
  "If you were to die this evening with no opportunity to communicate with anyone, what would you most regret not having told someone? Why haven’t you told them yet?",
  "Your house, containing everything you own, catches fire. After saving your loved ones and pets, you have time to safely make a final dash to save any one item. What would it be? Why?",
  "Of all the people in your family, whose death would you find most disturbing? Why?",
  "Share a personal problem and ask your buddy’s advice on how he or she might handle it. Also, ask your buddy to reflect back to you how you seem to be feeling about the problem you have chosen. ",
]

namespace :pairs do
  desc "generate_and_message"
  task :generate_and_message => :environment do
    client = Slack::Web::Client.new

    users = client.channels_info(channel: "#lunch-buddies").channel.members

    bot_id = client.users_info(user: "@lunch-roulette").user.id
    users.reject! { |user_id| user_id == bot_id }

    list = LunchRoulette::RegistrationList.new(users)
    list.generate_pairs
    list.pairs.each do |pair|
      topics = questions.sample(3)
      message = %(
*Hello there! Here's your lunch buddy tomorrow :smile:*\n
Need help with topics? I have 3 suggestions for you:\n
#{topics.map { |l| "• " + l }.join("\n")}
      )
      puts "messaging #{pair} #{pair.map { |u| client.users_info(user: u).user.real_name }} #{topics}"
      response = client.mpim_open(users: pair.join(","))
      channel_id = response.group.id
      client.chat_postMessage(channel: channel_id,
        text: message,
        as_user: true
      )
    end
  end
end
