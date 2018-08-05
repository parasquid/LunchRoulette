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

    # this can probably be moved to its own "strategy" object
    def generate_pairs
      @pairs = @users.shuffle.each_slice(2).to_a
      if @users.count.odd?
        @pairs[-2].concat @pairs.delete(@pairs[-1])
      end
      @pairs
    end
  end
end
