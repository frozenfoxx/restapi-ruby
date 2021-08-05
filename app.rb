require 'sinatra/base'
require 'sinatra/json'
require_relative './guestbook'

class RestAPI < Sinatra::Base

    configure do
        set :bind, ENV["HOST"]
        set :port, ENV["PORT"]
        set :threaded, true
    end

    def initialize
        @guestbook = Guestbook.new
        super
    end

    # Default route
    get '/' do
        body "Welcome to the guestbook"
    end
    
    get '/signatures' do
        begin
            json(@guestbook.signatures)
        rescue RuntimeError
            status 500
            json('Issue retrieving the signatures')
        end
    end

    post '/signatures/:id' do
        begin
            json(@guestbook.add(params[:id]))
        rescue RuntimeError
            status 409
            json('Signature already exists')
        end
    end

    get '/signatures/:id' do
        begin
            json(@guestbook.signatures[params[:id]])
        rescue RuntimeError
            status 404
            json('Unable to locate signature')
        end
    end

    put '/signatures/:id' do
        begin
            json(@guestbook.update(params[:id]))
        rescue RuntimeError
            status 401
            json('Unable to update signature')
        end
    end

    delete '/signatures/:id' do
        begin
            json(@guestbook.delete(params[:id]))
        rescue RuntimeError
            status 401
            json('Unable to delete signature')
        end
    end

    run! if __FILE__ == $0
end