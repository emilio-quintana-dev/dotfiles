Pry.config.editor = 'nvim'

require 'rubygems'
require 'pp'
require 'readline'
require 'rb-readline'

if defined?(RbReadline)
  def RbReadline.rl_reverse_search_history(_sign, _key)
    rl_insert_text `cat ~/.pry_history | fzf --tac |  tr '\n' ' '`
  end
end

color_escape_codes = {
  black: "\033[0;30m",
  red: "\033[0;31m",
  green: "\033[0;32m",
  yellow: "\033[0;33m",
  blue: "\033[0;34m",
  purple: "\033[0;35m",
  cyan: "\033[0;36m",
  reset: "\033[0;0m"
}

{
  'development' => color_escape_codes[:white],
  'test' => color_escape_codes[:purple],
  'staging' => color_escape_codes[:yellow],
  'production' => color_escape_codes[:red]
}

def app_name
  File.basename(Rails.root)
end
