# rsyncster
CMS -> Static site generation using standard \*nix utilities.

Philosophy is seven second rule. Seven seconds total to capture visitors attention. Only two seconds to stop their browsing. Avoid tl;dr. User experience is fast, clean, simple. Mobile optimized. Accessibility is important. Screen reader friendly. Open source, open cloud, 'cause your content is yours and should not be locked to your cloud provider.

This is very basic sloppy code, please vent your frustrations by fixing and sharing your awesome improvements. :)

__Status:__ __02dec2018 - Broke__. Need to update listicle on app_servers from wget_get_changes.pl. Pre-release version __rsyncster\_v.0.9.0.2-alpha-01dec2018__. First pass on synchronous downloads. Screwy logging, needs rewrite. Going to try rerun bash framework for standardized logging and installation. This version is for those who know their web backends. It is not polished.

__Dependencies__
* Perl
* Wget
* Rsync
* Sed
* Cron
* Find

__Backend environment__
* Haproxy
* Nginx
* Apache2 ( no config support )

__CMS assumptions__
* Simplified one-page interface. Bootstrap theme.
* Mobile emphasis. No menus, mobile users can't see, don't use.
* No ajax or sliding features etc.
* Deep functionality and ui complexity available with login.
* Public facing assets are obsessively lean and easily consumed.

__Rsyncster Installation__
* Git clone https://github.com/50ten40/rsyncster.git to your management directory.
* No documentation, you'll just have to read the code.
* Usage: Call cron\_get\_changes.sh from cron entry. Each script component in main.sh can be called standalone. Pass a domain name or option. There are helper scripts in ./extras.
* Configure variables for your setup.

__Basic Drupal Workflow__
* Change top level dns record. eg domain.tld -> subdomain.domain.tld
* Update $base_url in settings.php (required)
* Edit site according to CMS assumptions above. eg Strip out everything that is unneccessary.
* Enable anonymous page caching (required)
* Turn off database logging (optional)
* Verify custom logos and favicon. Set in theme and global settings.(optional)
* Update scripts with your subdomain
* Run scripts as needed
* Enjoy your new peace of mind.
