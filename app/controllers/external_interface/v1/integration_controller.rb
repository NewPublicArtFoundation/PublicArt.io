module ExternalInterface
  module V1
    class IntegrationController < ApplicationController

      def instagrams
      end

      def instagramOauthCallback
        response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
        session[:access_token] = response.access_token
        redirect root_path
      end

      def instagramOauthConnect
        redirect Instagram.authorize_url(:redirect_uri => CALLBACK_URL)
      end

      def instagramResponse
      end

      def flickr
      end
    end
  end
end
