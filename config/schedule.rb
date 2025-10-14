
env :TZ, 'America/Argentina/Buenos_Aires'

rails_env = ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'

set :environment, rails_env
APP_ROOT  = File.expand_path('..', __dir__)
set :job_template, %q{
  /bin/bash -lc '
    export PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:$PATH";
    if command -v mise >/dev/null 2>&1; then eval "$(mise activate bash)" >/dev/null 2>&1; fi;
    :job
  '
}.strip

set :output, {
  standard: "log/cron_#{rails_env}.log",
  error:    "log/cron_#{rails_env}.error.log"
}

every :weekday, at: '6:00 am' do
  rake "asistencia_gral:crear_diaria"
end

every :weekday, at: '6:00 am' do
  rake "asistencia_mat:crear_diaria"
end

every 3.minutes do
    rake "asistencia_mat:crear_diaria"
end