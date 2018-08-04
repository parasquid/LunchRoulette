module LunchRoulette
  class RegistrationList
    def initialize(users = [])
      @users = users
    end

    def registrants
      @users
    end

    def register(user)
      @users << user
    end
  end
end
