var/global/runtime_diary = null


var/global/list/combatlog = list()
var/global/list/IClog     = list()
var/global/list/OOClog    = list()
var/global/list/adminlog  = list()

var/global/datum/configuration/config      = null
var/global/list/jobMax        = list()

var/global/diary               = null

GLOBAL_VAR(log_directory)
GLOBAL_PROTECT(log_directory)
