require "dry-types"
require "dry-struct"

module Types
  include Dry::Types.module
end

module LunchRoulette
  class User < Dry::Struct
    attribute :name, Types::Coercible::String
  end
end
