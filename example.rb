require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'
require 'haml'
require 'redis'
require 'socket'

class Example < Sinatra::Base
  before do
    @redis = Redis.new(host: ENV['REDIS_PORT_6379_TCP_ADDR'], port: ENV['REDIS_PORT_6379_TCP_PORT'])
  end

  get '/' do
    @entries = @redis.mapped_mget(*get_all_keys)
    @env_vars = ENV
    @hostname = Socket.gethostname

    haml :index
  end

  post '/set' do
    @redis.set params[:key], params[:value]
    redirect to('/')
  end

  private

  def get_all_keys
    keys = @redis.keys('*')
    keys = ['foo'] if keys.size < 1 # Default to one dummy argument if no keys are present

    keys
  end
end
