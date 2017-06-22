# frozen_string_literal: true

FAYE_TOKEN = if ENV['RAILS_ENV'] == 'production'
               ENV['FAYE_TOKEN']
             else
               'ceba6ed9ee48e5b11b1a72f23b260bc8df447298'
             end
