Capistrano::Configuration.instance(:must_exist).load do
  namespace :bundler do
    desc "Automatically installed your bundled gems if a Gemfile exists"
    task :bundle_gems do
      # run "if [ -f #{release_path}/Gemfile ]; then cd #{release_path} && bundle install --without=test,development; fi"
      run "if [ -f #{release_path}/Gemfile ]; then cd #{release_path} && bundle install --path #{shared_path}/bundled_gems --deployment --without development test; fi"
      run "if [ -f #{release_path}/Gemfile ]; then ln -nfs #{shared_path}/bundled_gems #{latest_release}/vendor/bundle; fi"
    end
    after "deploy:symlink_configs","bundler:bundle_gems"
  end
end