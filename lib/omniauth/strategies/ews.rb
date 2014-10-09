require 'viewpoint'
require 'omniauth-http-basic'
#include Viewpoint::EWS

module OmniAuth
  module Strategies
    class Ews
      include OmniAuth::Strategy

      args [:endpoint]

      option :title, "Exchange Login"
      option :endpoint, nil

      uid { username }

      credentials { {:username => username, :password => password} }

      info do
        { :name => authentication_response[:name],
          :email => authentication_response[:email]
        }
      end

      extra do
        { #:number => content_of('Profile/details/number'),
          #:extension => content_of('Profile/details/extension'),
          #:group     => content_of('Profile/details/groupId'),
          #:provider  => content_of('Profile/details/serviceProvider') 
        }
      end

      def request_phase
        OmniAuth::Form.build(:title => options.title, :url => callback_path) do
          text_field 'Username', 'username'
          password_field 'Password', 'password'
        end.to_response
      end

      def callback_phase
        return fail!(:invalid_credentials) if !authentication_response
        super
      end

      protected

        def endpoint
          options[:endpoint]
        end

        def username
          request['username']
        end

        def password
          request['password']
        end

        def authentication_response
          unless @authentication_response
            return unless username && password && endpoint

            begin
              cli = Viewpoint::EWSClient.new endpoint, username, password, http_opts: {ssl_verify_mode: 0}
              u = cli.search_contacts(username)
              return if u.empty?
              @authentication_response = {}
              @authentication_response[:name] = u[0].name
              @authentication_response[:email] = u[0].email_address
            rescue Viewpoint::EWS::Errors::UnauthorizedResponseError => e
              return
            end
          end
          @authentication_response
        end

    end
  end
end