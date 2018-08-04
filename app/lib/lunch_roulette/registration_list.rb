module LunchRoulette
  class RegistrationList
    attr_reader :pairs

    def initialize(users = [])
      @users = users
      @pairs = {}
    end

    def registrants
      @users
    end

    def register(user)
      @users << user
    end

    def generate_pairs
      @pairs = @users.shuffle.each_slice(2).to_a
    end
  end
end
