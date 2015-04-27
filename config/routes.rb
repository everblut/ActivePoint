Rails.application.routes.draw do
  get 'homeworks/index'

  get 'homeworks/show'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'exercises#new'
  resources :exercises, only: [:new,:create]
  resources :teachers, only: [:index, :show]
  resources :courses, only: [:index, :show]
  resources :homeworks, only: [:index, :show]
  get '/fetch_courses/:teacher_id' => 'exercises#courses_from_teacher', as: 'fetch_courses'
  get '/fetch_homeworks/:course_id' => 'exercises#homeworks_from_course', as: 'fetch_homeworks'

end
