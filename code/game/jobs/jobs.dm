var/global/const/ENG               =(1<<0)
var/global/const/SEC               =(1<<1)
var/global/const/MED               =(1<<2)
var/global/const/SCI               =(1<<3)
var/global/const/CIV               =(1<<4)
var/global/const/COM               =(1<<5)
var/global/const/CRG               =(1<<6)
var/global/const/MSC               =(1<<7)
var/global/const/SRV               =(1<<8)
var/global/const/SUP               =(1<<9)
var/global/const/SPT               =(1<<10)

var/global/list/assistant_occupations = list(
)

var/global/list/command_positions = list(
)

var/global/list/engineering_positions = list(
)

var/global/list/medical_positions = list(
)

var/global/list/science_positions = list(
)

var/global/list/cargo_positions = list(
)

var/global/list/civilian_positions = list(
)


var/global/list/security_positions = list(
)

var/global/list/nonhuman_positions = list(
	"pAI"
)

var/global/list/service_positions = list(
)

var/global/list/supply_positions = list(
)

var/global/list/support_positions = list(
)


/proc/guest_jobbans(var/job)
	return ((job in command_positions) || (job in nonhuman_positions) || (job in security_positions))

/proc/get_job_datums()
	var/list/occupations = list()
	var/list/all_jobs = typesof(/datum/job)

	for(var/A in all_jobs)
		var/datum/job/job = new A()
		if(!job)	continue
		occupations += job

	return occupations

/proc/get_alternate_titles(var/job)
	var/list/jobs = get_job_datums()
	var/list/titles = list()

	for(var/datum/job/J in jobs)
		if(J.title == job)
			titles = J.alt_titles

	return titles
