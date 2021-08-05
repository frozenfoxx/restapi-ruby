require 'sinatra/base'
require_relative './guestbook'

class RestAPI < Sinatra::Base

    configure do
        set :bind, ENV["HOST"]
        set :port, ENV["PORT"]
        @guestbook = Guestbook.new
    end

    # Default route
    get '/' do
        body "Welcome to the guestbook"
    end
    
    get '/signatures' do
        begin
            @guestbook.signatures
        rescue RuntimeError
            status 500
            body 'Issue retrieving the signatures'
        end
    end

    post '/signatures/:id' do
        begin
            @guestbook.add(params[:id])
        rescue
            status 409
            body 'Signature already exists'
        end
    end

    get '/signatures/:id' do
        begin
            @guestbook.signatures[params[:id]]
        rescue
            status 404
            body 'Unable to locate signature'
        end
    end

    put '/signatures/:id' do
        begin
            @guestbook.update(params[:id])
        rescue
            status 401
            body 'Unable to update signature'
        end
    end

    delete '/signatures/:id' do
        begin
            @guestbook.delete(params[:id])
        rescue
            status 401
            body 'Unable to delete signature'
        end
    end

    run! if __FILE__ == $0
end