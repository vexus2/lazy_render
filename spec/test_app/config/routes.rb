Rails.application.routes.draw do

  root 'top#index'

  lazy_render_for 'lazy_render/load', to: 'lazy_render'
end
