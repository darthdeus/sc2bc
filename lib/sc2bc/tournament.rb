require_relative './api'

module Bracket

  class Tournament

    attr_reader :id

    DEFAULT_OPTS = {
      name: "SCV Rush BSG #20",
      begin: "2011-07-07T18:05:00+00:00",
      end: "-0001-11-30T00:00:00+00:00",
      registration_begin: "2011-07-05T13:05:00+00:00",
      registration_end: "2011-07-07T17:30:00+00:00",
      confirmation_begin: "2011-07-07T17:30:00+00:00",
      confirmation_end: "2011-07-07T17:55:00+00:00"
    }

    class << self

      # Create a new tournament via the API
      def create(options)
	instance = Tournament.new(options)
	instance.create!
	instance
      end

      def create_default(options = {})
	instance = Tournament.new(DEFAULT_OPTS.merge(options))
	instance.create!
	instance
      end

    end

    def initialize(options)
      @options = options
      @name = options[:name]
      @id = 1
    end

    def success?
      @response[:status] == :ok
    end

    def create!
      @response = API.create_tournament(@options)
    end

    def destroy!
      @response = API.destroy_tournament(self.id)
    end

  end

end
