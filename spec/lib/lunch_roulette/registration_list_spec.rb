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
end
