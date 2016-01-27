# = Redmine configuration file
#
# Each environment has it's own configuration options.  If you are only
# running in production, only the production block needs to be configured.
# Environment specific configuration options override the default ones.
#
# Note that this file needs to be a valid YAML file.
# DO NOT USE TABS! Use 2 spaces instead of tabs for identation.
#
# == Outgoing email settings (email_delivery setting)
#
# === Common configurations
#
# ==== Sendmail command
#
# production:
#   email_delivery:
#     delivery_method: :sendmail
#
# ==== Simple SMTP server at localhost
#
# production:
#   email_delivery:
#     delivery_method: :smtp
#     smtp_settings:
#       address: "localhost"
#       port: 25
#
# ==== SMTP server at example.com using LOGIN authentication and checking HELO for foo.com
#
# production:
#   email_delivery:
#     delivery_method: :smtp
#     smtp_settings:
#       address: "example.com"
#       port: 25
#       authentication: :login
#       domain: 'foo.com'
#       user_name: 'myaccount'
#       password: 'password'
#
# ==== SMTP server at example.com using PLAIN authentication
#
# production:
#   email_delivery:
#     delivery_method: :smtp
#     smtp_settings:
#       address: "example.com"
#       port: 25
#       authentication: :plain
#       domain: 'example.com'
#       user_name: 'myaccount'
#       password: 'password'
#
# ==== SMTP server at using TLS (GMail)
#
# This might require some additional configuration. See the guides at:
# http://www.redmine.org/projects/redmine/wiki/EmailConfiguration
#
# production:
#   email_delivery:
#     delivery_method: :smtp
#     smtp_settings:
#       enable_starttls_auto: true
#       address: "smtp.gmail.com"
#       port: 587
#       domain: "smtp.gmail.com" # 'your.domain.com' for GoogleApps
#       authentication: :plain
#       user_name: "your_email@gmail.com"
#       password: "your_password"
#
#
# === More configuration options
#
# See the "Configuration options" at the following website for a list of the
# full options allowed:
#
# http://wiki.rubyonrails.org/rails/pages/HowToSendEmailsWithActionMailer


# default configuration options for all environments
default:
  # Outgoing emails configuration (see examples above)
  email_delivery:
    delivery_method: :smtp
    smtp_settings:
      address: smtp.example.net
      port: 25
      domain: example.net
      authentication: :login
      user_name: "redmine@example.net"
      password: "redmine"

  # Absolute path to the directory where attachments are stored.
  # The default is the 'files' directory in your Redmine instance.
  # Your Redmine instance needs to have write permission on this
  # directory.
  # Examples:
  # attachments_storage_path: /var/redmine/files
  # attachments_storage_path: D:/redmine/files
  attachments_storage_path:

  # Configuration of the autologin cookie.
  # autologin_cookie_name: the name of the cookie (default: autologin)
  # autologin_cookie_path: the cookie path (default: /)
  # autologin_cookie_secure: true sets the cookie secure flag (default: false)
  autologin_cookie_name:
  autologin_cookie_path:
  autologin_cookie_secure:

  # Configuration of SCM executable command.
  #
  # Absolute path (e.g. /usr/local/bin/hg) or command name (e.g. hg.exe, bzr.exe)
  # On Windows + CRuby, *.cmd, *.bat (e.g. hg.cmd, bzr.bat) does not work.
  #
  # On Windows + JRuby 1.6.2, path which contains spaces does not work.
  # For example, "C:\Program Files\TortoiseHg\hg.exe".
  # If you want to this feature, you need to install to the path which does not contains spaces.
  # For example, "C:\TortoiseHg\hg.exe".
  #
  # Examples:
  # scm_subversion_command: svn                                       # (default: svn)
  # scm_mercurial_command:  C:\Program Files\TortoiseHg\hg.exe        # (default: hg)
  # scm_git_command:        /usr/local/bin/git                        # (default: git)
  # scm_cvs_command:        cvs                                       # (default: cvs)
  # scm_bazaar_command:     bzr.exe                                   # (default: bzr)
  # scm_darcs_command:      darcs-1.0.9-i386-linux                    # (default: darcs)
  #
  scm_subversion_command:
  scm_mercurial_command:
  scm_git_command:
  scm_cvs_command:
  scm_bazaar_command:
  scm_darcs_command:

  # Absolute path to the SCM commands errors (stderr) log file.
  # The default is to log in the 'log' directory of your Redmine instance.
  # Example:
  # scm_stderr_log_file: /var/log/redmine_scm_stderr.log
  scm_stderr_log_file:

  # Key used to encrypt sensitive data in the database (SCM and LDAP passwords).
  # If you don't want to enable data encryption, just leave it blank.
  # WARNING: losing/changing this key will make encrypted data unreadable.
  #
  # If you want to encrypt existing passwords in your database:
  # * set the cipher key here in your configuration file
  # * encrypt data using 'rake db:encrypt RAILS_ENV=production'
  #
  # If you have encrypted data and want to change this key, you have to:
  # * decrypt data using 'rake db:decrypt RAILS_ENV=production' first
  # * change the cipher key here in your configuration file
  # * encrypt data using 'rake db:encrypt RAILS_ENV=production'
  database_cipher_key:

  # Set this to false to disable plugins' assets mirroring on startup.
  # You can use `rake redmine:plugins:assets` to manually mirror assets
  # to public/plugin_assets when you install/upgrade a Redmine plugin.
  #
  #mirror_plugins_assets_on_startup: false

  # Your secret key for verifying cookie session data integrity. If you
  # change this key, all old sessions will become invalid! Make sure the
  # secret is at least 30 characters and all random, no regular words or
  # you'll be exposed to dictionary attacks.
  #
  # If you have a load-balancing Redmine cluster, you have to use the
  # same secret token on each machine.
  #secret_token: 'change it to a long random string'

  # Absolute path (e.g. /usr/bin/convert, c:/im/convert.exe) to
  # the ImageMagick's `convert` binary. Used to generate attachment thumbnails.
  #imagemagick_convert_command:

  # Configuration of RMagcik font.
  #
  # Redmine uses RMagcik in order to export gantt png.
  # You don't need this setting if you don't install RMagcik.
  #
  # In CJK (Chinese, Japanese and Korean),
  # in order to show CJK characters correctly,
  # you need to set this configuration.
  #
  # Because there is no standard font across platforms in CJK,
  # you need to set a font installed in your server.
  #
  # This setting is not necessary in non CJK.
  #
  # Examples for Japanese:
  #   Windows:
  #     rmagick_font_path: C:\windows\fonts\msgothic.ttc
  #   Linux:
  #     rmagick_font_path: /usr/share/fonts/ipa-mincho/ipam.ttf
  #
  rmagick_font_path:

  # Maximum number of simultaneous AJAX uploads
  #max_concurrent_ajax_uploads: 2

# specific configuration options for production environment
# that overrides the default ones
production:
  smtp_settings:
    address: {{PROJECT_SMTP_HOST}}
    port: 587
    domain: {{PROJECT_SMTP_DOMAIN}}
    authentication: :login
    user_name: "{{PROJECT_SMTP_USER}}"
    password: "{{PROJECT_SMTP_PASSWORD}}"

# specific configuration options for development environment
# that overrides the default ones
development:
