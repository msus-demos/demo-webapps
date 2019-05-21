Rails.application.routes.draw do
  get '/rails/info/properties' => "rails/info#properties"
  get '/rails/info/routes'     => "rails/info#routes"
  get '/rails/info'            => "rails/info#index"
  get '/'                      => "rails/welcome#index"
end
