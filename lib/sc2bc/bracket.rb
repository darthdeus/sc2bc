require 'json'
require 'rest-client'
require 'yaml'

module Bracket

  # SC2BC API wrapper
  class API

    PREFIX = "https://beta.sc2bc.com/api"
    LOGIN = "https://beta.sc2bc.com/user/sign/in?do=signInForm-submit"

    class << self
      def instance
	@instance ||= self.new
      end

      def method_missing(method, *args)
	instance.send(method, *args)
      end

    end

    # Load and parse YML config
    def load_config
      config = YAML.load_file(File.dirname(File.expand_path(__FILE__)) +
			      "/../../config/sc2bc.yml")
      @username = config[:username]
      @token = config[:token]
      @auth = { username: @username, token: @token }.freeze
    end

    def initialize
      # TODO - add some kind of validation API for the login credentials
      load_config
    end

    # Authenticate to the API for given credential
    def login_via_form
      RestClient.post(LOGIN, { username: @username, password: @password })
    end

    # Create a new tournament and return it's ID
    #
    # {
    #   name: "SCV Rush BSG #20",
    #   begin: "2011-07-07T18:05:00+00:00",
    #   end: "-0001-11-30T00:00:00+00:00",
    #   registration_begin: "2011-07-05T13:05:00+00:00",
    #   registration_end: "2011-07-07T17:30:00+00:00",
    #   confirmation_begin: "2011-07-07T17:30:00+00:00",
    #   confirmation_end: "2011-07-07T17:55:00+00:00"
    # }
    def create_tournament(options)
      response = RestClient.post "#{PREFIX}/tournament", @auth.merge(options)
    end

    # Set players for a given tournament
    #
    # tournament - id of the tournament
    # players    - an Array of players, such as
    #        [{
    #          email: "foobar@example.com",
    #          code: 222,
    #          name: "foobar"
    #         }, ...]
    def set_players(tournament, players)
      data = {
        players: players.to_json,
        username: @username,
        token: @token,
        id: tournament
      }
      RestClient.post "#{PREFIX}/tournament/set_players", data
    end

    # Delete a tournament for a given ID
    def destroy_tournament(id)
      RestClient.delete "#{PREFIX}/tournament/#{id}"
    end

    # Start a given tournament
    def start
      RestClient.post "#{PREFIX}/tournament/start"
    end

    # Returns a parsed JSON response
    def parse(response)
      JSON.parse(response)
    end

  end

end
