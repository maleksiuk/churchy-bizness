
rvm_path=/home/mike/.rvm
source "/home/mike/.rvm/scripts/rvm"
/usr/bin/env RAILS_ENV=production /home/mike/.rvm/rubies/ruby-2.1.0/bin/ruby /var/www/churchybizness/churchybizness/bin/delayed_job restart &>> /var/www/churchybizness/churchybizness/bin/start_delayed_job.txt
