require "spec_helper"
require "lib/lunch_roulette/registration_list.rb"
require "lib/lunch_roulette/user.rb"

describe LunchRoulette::RegistrationList do
  context "users can be retrieved from the registration list" do
    Given(:users) { (1..3).map { |index| LunchRoulette::User.new(name: index) } }
    Given(:list) { LunchRoulette::RegistrationList.new(users) }
    When(:result) { list.registrants }
    Then { result.count == 3 }
    Then { result[0].name == "1" }
  end

  context "users can be added into the registration list" do
    Given(:user) { LunchRoulette::User.new(name: "Tristan") }
    Given(:list) { LunchRoulette::RegistrationList.new }
    When { list.register(user) }
    Then { list.registrants.count == 1 }
    Then { list.registrants[0].name == "Tristan" }
  end

  context "users can be paired up and this list can be retrieved" do
    Given(:users) { (1..2).map { |index| LunchRoulette::User.new(name: index) } }
    Given(:list) { LunchRoulette::RegistrationList.new(users) }
    When(:result) { list.generate_pairs }
    Then { result.count == 1 }
    Then {
      (result[0][0] == users[0] && result[0][1] == users[1]) ||
      (result[0][1] == users[0] && result[0][0] == users[1])
    }
    Then { list.pairs == result }
  end

  context "with odd number of participants" do
    Given(:users) { (1..3).map { |index| LunchRoulette::User.new(name: index) } }
    Given(:list) { LunchRoulette::RegistrationList.new(users) }
    context "the last pair is a triad" do
      When(:result) { list.generate_pairs }
      Then { result.count == 1 }
      Then {
        puts result.inspect
        result[0].count == 3
      }
    end
  end
end
