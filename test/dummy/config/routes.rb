# frozen_string_literal: true

Rails.application.routes.draw do
  mount Blimp::Engine => "/blimp"
end
