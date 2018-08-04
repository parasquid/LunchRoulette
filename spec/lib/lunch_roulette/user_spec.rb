require "spec_helper"
require "lib/lunch_roulette/user.rb"

describe LunchRoulette::User do
  context "returns the user's name" do
    Given(:control_name) { "Tristan" }
    Given(:user) { LunchRoulette::User.new(name: control_name) }
    When(:name) { user.name }
    Then { name == control_name }
  end

  context "names are always strings" do
    Given(:control_name) { "1" }
    Given(:user) { LunchRoulette::User.new(name: 1) }
    When(:name) { user.name }
    Then { name == control_name }
  end
end
