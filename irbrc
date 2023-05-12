IRB.conf[:USE_AUTOCOMPLETE] = false

# Stolen from Chris Toomey's dotfiles:
# http://github.com/christoomey/dotfiles
ANSI = {}
ANSI[:RESET]     = "\e[0m"
ANSI[:BOLD]      = "\e[1m"
ANSI[:UNDERLINE] = "\e[4m"
ANSI[:LGRAY]     = "\e[0;37m"
ANSI[:GRAY]      = "\e[0;90m"
ANSI[:RED]       = "\e[31m"
ANSI[:GREEN]     = "\e[32m"
ANSI[:YELLOW]    = "\e[33m"
ANSI[:BLUE]      = "\e[34m"
ANSI[:MAGENTA]   = "\e[35m"
ANSI[:CYAN]      = "\e[36m"
ANSI[:WHITE]     = "\e[37m"

def formatted_env
  if ENV["COMMONLIT_NAMESPACE"].present?
    "#{ANSI[:BOLD]}#{ANSI[:CYAN]}#{ENV['COMMONLIT_NAMESPACE'].upcase}#{ANSI[:RESET]} - #{ENV['PORTER_POD_IMAGE_TAG']}"
  elsif ENV["DEVELOPMENT_DATABASE_URL"].present?
    "dev #{ANSI[:RED]}#{ANSI[:BOLD]}REMOTE DB#{ANSI[:RESET]}"
  else
    Rails.env
  end
end

def db_endpoint
  endpoint_name = ApplicationRecord.connection_db_config.host.to_s.split(".").first || "unknown"

  if endpoint_name.match?(/production-/)
    "#{ANSI[:RED]}#{ANSI[:BOLD]}#{endpoint_name}#{ANSI[:RESET]}"
  elsif endpoint_name == "localhost"
    endpoint_name
  else
    "#{ANSI[:CYAN]}#{endpoint_name}#{ANSI[:RESET]}"
  end
end

# Checking if we are in rails console
if defined?(Rails)
  prompt = "[commonlit][#{formatted_env}][DB: #{db_endpoint}] %m:%i"
  # defining custom prompt
  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:RAILS] = {
    PROMPT_I: "#{prompt}> ",
    PROMPT_N: "#{prompt}> ",
    PROMPT_S: "#{prompt}* ",
    PROMPT_C: "#{prompt}? ",
    RETURN: " => %s\n",
  }

  IRB.conf[:PROMPT_MODE] = :RAILS
end

def pbcopy(data)
  File.popen("pbcopy", "w") { |p| p << data.to_s }
  $?.success?
end
