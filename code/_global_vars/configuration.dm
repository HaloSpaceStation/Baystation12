// Bomb cap!
GLOBAL_VAR_INIT(max_explosion_range, 14)


var/global/href_logfile        = null
var/global/game_version        = "Halo: Space Station Evolved"
var/global/changelog_hash      = ""
var/global/game_year           = 2540 //HALO STUFF, WAS (text2num(time2text(world.realtime, "YYYY")) + 512)
var/global/join_motd = null

var/global/master_mode       = "extended" // "extended"
var/global/secondary_mode    = "extended"
var/global/tertiary_mode     = "extended"
var/global/secret_force_mode = "secret"   // if this is anything but "secret", the secret rotation will forceably choose this mode.

var/global/Debug2 = 0

var/global/gravity_is_on = 1
var/global/round_progressing = 1

// Database connections. A connection is established on world creation.
// Ideally, the connection dies when the server restarts (After feedback logging.).
var/global/DBConnection/dbcon     = new() // Feedback    database (New database)
var/global/DBConnection/dbcon_old = new() // /tg/station database (Old database) -- see the files in the SQL folder for information on what goes where.


// For FTP requests. (i.e. downloading runtime logs.)
// However it'd be ok to use for accessing attack logs and such too, which are even laggier.
var/global/fileaccess_timer = 0
var/global/custom_event_msg = null
