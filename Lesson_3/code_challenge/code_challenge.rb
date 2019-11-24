require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "yaml"

before do
  @user_hash = YAML.load_file("users.yaml")
  @users = @user_hash.map{|k, v| k}
end

helpers do 
  def count_interests 
    interest_count = 0
    @user_hash.each_value do |v|
      interest_count += v[:interests].size
    end

    interest_count
  end
end

get "/" do
  erb :home
end

get "/:name" do
  @name = params[:name].to_sym
  redirect "/" unless @users.include?(@name)

  @email = @user_hash[@name][:email]
  @interests = @user_hash[@name][:interests]

  erb :user
end