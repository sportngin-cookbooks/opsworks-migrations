# Setup for test kitchen
group "nginx"
user "deploy"

remote_directory "/srv/www/test_app/migrations/current" do
  source "test_app"
end