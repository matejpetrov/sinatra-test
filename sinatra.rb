require 'sinatra'

get '/' do
  File.read('index.html')
end

post '/another' do
  puts "Hello, world!"
  File.read('another.html')
end